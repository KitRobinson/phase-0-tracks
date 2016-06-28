### More Questions

**What are some of the key design philosophies of the Linux operating system?**

The key design philosophy in Linus is to respect the user by allowing them the highest degree of control.  Linux commands can do powerful (and potentially horrible) things, but the flexibility to execute these is necessary in order to do clever and cool things as well.

**In your own words, what is a VPS (virtual private server)? What, according to your research, are the advantages of using a VPS?**

A VPS is a virtual machine (a section of computer memory and software emulating an independent machine, with its own operating system etc.) which is set up as a server.  This is very handy becuase it allows one to 'rent' space online for a VPS which is much cheaper than running a physical server.  Also, since it is very easy to create and remove a VPS, it's ok to make horrible mistakes one one!

**Optional bonus question: Why is it considered a bad idea to run programs as the root user on a Linux system?**

Despite the philosophy that all users should have lots of power and flexibility, there are still some limitations on what different users can do - such as modify the most basic root directory.  Other users may have this power if it is granted (and might need to confirm with a password or some such) but the root user has the ability to do things like replace all the system commands with random garbage - running programs as root could cause problems if they are flawed (or intentionally malicious!)