python
import sys, os.path, gdb

sys.path.insert(0, os.path.expanduser('~/.gdb'))
import qt5printers
qt5printers.register_printers(gdb.current_objfile())

sys.path.insert(0, os.path.expanduser('~/.gdb/python'))
from libstdcxx.v6.printers import register_libstdcxx_printers
register_libstdcxx_printers (gdb.current_objfile())
end




# define rprogram
#     echo ---- STARTING TO DEBUG PROGRAM ----\n
#     r <<params>>  2> err.log > console.log
# end


# define connect
#     target remote localhost:12345
# end


python
class ListGTests(gdb.Command):
  """ Lists all Google Test functions """

  def __init__ (self):
    super(ListGTests, self).__init__("listgtests", gdb.COMMAND_USER)

  def invoke (self, name, from_tty):
    print( name)
    gdb.execute('info func TestBody')

ListGTests()

class GTBreakpoint(gdb.Command):
  """ Creates breakpoints in test bodies of Google Test functions matching regex """

  def __init__ (self):
    super(GTBreakpoint, self).__init__("breakgtest", gdb.COMMAND_USER)

  def invoke (self, name, from_tty):
    if not name:
       print("usage:  breakgtest <testname regex>")
       return

    regexp = "%s.*TestBody" % name
    gdb.execute('rbreak {:s}'.format(regexp))

GTBreakpoint()

class GTRunner(gdb.Command):
  """ Runs unit tests, filtered to tests that contains the testname"""

  def __init__ (self):
    super(GTRunner, self).__init__("rungtest", gdb.COMMAND_USER)

  def invoke (self, name, from_tty):
    if not name:
       print("usage:  rungtest <testname>")
       return

    gdb.execute('r --gtest_filter="*{:s}*"'.format(name))

GTRunner()
end

alias bgt=breakgtest
alias lgt=listgtests
alias rgt=rungtest

set print thread-events off

skip QString::fromStdString(std::string const&)
skip QString::toStdString()
skip QString::~QString
skip EventLogger::GetInstance()
skip itk::SmartPointer::operator->()
skip -rfu "itk::WeakPointer<.*>::operator->() const"
skip -rfu "QSharedPointer<.*>::operator->() const"
skip -rfu "QList<.*>::const_iterator::operator*"
skip -rfu "std::unique_ptr<.*>::operator->() const"

# set substitute-path <path1> <path2>

tui enable

