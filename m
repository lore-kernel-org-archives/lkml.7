Return-Path: <SRS0=Yvat=2B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF03C2D0C6
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:53:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9824320836
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Dec 2019 20:53:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKUxV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Dec 2019 15:53:21 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:33265 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726313AbfLKUxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Dec 2019 15:53:21 -0500
Received: from threadripper.lan ([149.172.19.189]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MNbxN-1iLXWl00p1-00P20M; Wed, 11 Dec 2019 21:53:04 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     linux-kernel@vger.kernel.org, y2038@lists.linaro.org,
        Arnd Bergmann <arnd@arndb.de>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        linux-doc@vger.kernel.org
Subject: [PATCH 24/24] Documentation: document ioctl interfaces better
Date:   Wed, 11 Dec 2019 21:42:58 +0100
Message-Id: <20191211204306.1207817-25-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20191211204306.1207817-1-arnd@arndb.de>
References: <20191211204306.1207817-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:aX83qY2gzIb1UH/MGpptCcNx3Fm7jzI7Op46RwEngICWEsKbKJN
 +aB7rHtumg4Q8zjAEcbg8JF+GwQKoWsmw+eVpuk9HuyhQ6K9c95DCG29r4mNe5FipNvkFN3
 67RUuhau+/vsEiZFpWPoXowNU15R94B8sP26iKibS8kY2W8VcXdU+8WT/w3jOCsowLkJuk6
 1CjcV4L6aRdT1CxCbkRWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:1lOjHeULC1c=:jEdbpOrh8ZnOFDTj9moCuP
 NZ/yy9AdO26TLdpn2YZaWxVYi0oQoCY6GemZOwTMQGVu5ZFPxOlrWtSCLJYu8lF2UihygYaNa
 KpdquzCEUuUswjQciRokgyfP+XOwNTsepKzA0Nbz5u6qsp1igs8qUcE29q5iaqXzGCdsQ+N9N
 TDEOc8CoLKkD35EmOcFX4A6MwLytKyFDddcLTQPfrX5op3yLTHtqpFOxj7tyxtPWBD4tnjIjU
 aB0NdC2k8PMK58sHxugu4yEGTC3ImlyvRrnq+NWQLUV+Qw8hGvDTe9sGY5hN69In2RYI8o/iQ
 BbtlQI6gieWS6bNAZZTQE03/Zxcw2ZBt+E4c83SLabBVTRcKKyVHkGts8mA/yhLL0BJBVYOt1
 x53yvAD6YJWCzjSksDpTcPsJ2mKh9K+T1xxyMgWFrZmC0MDLmhmv9bmIQ5Lz1I0VYm+11jkri
 kcGb4FmGhMwCFH/mZkCuLCWDD0cJGin3dIFy+Kj5tXZVN9YAiw8IvKtcJKzoQwq0kMAEFEslx
 S0wzpX4NJ+8DfiR93a+6XxJ/hu+Gqidu90Sv3PNpPznbv2KhZOsnl0k8jVUKVKeZhcVrkUSyd
 j7Fb3owOK7loApQocdDRgMvc1oNMJNszjHYI5ySLXedbVClebSBsCulyBXyZD9kqzVNZDuxBc
 dwJvXtcjRU2khOPZF8wrq29nohZtCc48aR0gEzdt58yKg0ZvWHSi9hS6pnBtYRMb/A0Pt70pV
 GhPE/hZf/0Lbc/0clAF6GW0sAMh8WR7hp3I4lz69tEzUUORDu45Q1Rspa/w3hS6PcPMZE3bZB
 RSWI8saJ/qvWY+2fNqO5hEMHbdQrn3HUSR1CPKqn8p3R+fWSoU9w3L+DxrDDf5RT7a/RBv2oH
 rE96sNcEXYcI6x53pkvg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Documentation/process/botching-up-ioctls.rst was orignally
written as a blog post for DRM driver writers, so it it misses
some points while going into a lot of detail on others.

Try to provide a replacement that addresses typical issues
across a wider range of subsystems, and follows the style of
the core-api documentation better.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/core-api/index.rst |   1 +
 Documentation/core-api/ioctl.rst | 250 +++++++++++++++++++++++++++++++
 2 files changed, 251 insertions(+)
 create mode 100644 Documentation/core-api/ioctl.rst

diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
index ab0eae1c153a..3f28b2f668be 100644
--- a/Documentation/core-api/index.rst
+++ b/Documentation/core-api/index.rst
@@ -39,6 +39,7 @@ Core utilities
    ../RCU/index
    gcc-plugins
    symbol-namespaces
+   ioctl
 
 
 Interfaces for kernel debugging
diff --git a/Documentation/core-api/ioctl.rst b/Documentation/core-api/ioctl.rst
new file mode 100644
index 000000000000..cb2c86ae63e7
--- /dev/null
+++ b/Documentation/core-api/ioctl.rst
@@ -0,0 +1,250 @@
+======================
+ioctl based interfaces
+======================
+
+:c:func:`ioctl` is the most common way for applications to interface
+with device drivers. It is flexible and easily extended by adding new
+commands and can be passed through character devices, block devices as
+well as sockets and other special file descriptors.
+
+However, it is also very easy to get ioctl command definitions wrong,
+and hard to fix them later without breaking existing applications,
+so this documentation tries to help developers get it right.
+
+Command number definitions
+==========================
+
+The command number, or request number, is the second argument passed to
+the ioctl system call. While this can be any 32-bit number that uniquely
+identifies an action for a particular driver, there are a number of
+conventions around defining them.
+
+``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
+ioctl commands that follow modern conventions: ``_IOC``, ``_IOR``,
+``_IOW``, and ``_IORW``. These should be used for all new commands,
+with the correct parameters:
+
+_IO/_IOR/_IOW/_IOWR
+   The macro name determines whether the argument is used for passing
+   data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is
+   not a pointer (_IOC). It is possible but not recommended to pass an
+   integer value instead of a pointer with _IOC.
+
+type
+   An 8-bit number, often a character literal, specific to a subsystem
+   or driver, and listed in :doc:`../ioctl/ioctl-number`
+
+nr
+  An 8-bit number identifying the specific command, unique for a give
+  value of 'type'
+
+size
+  The name of the data type pointed to by the argument, the command
+  number encodes the ``sizeof(size)`` value in a 13-bit or 14-bit integer,
+  leading to a limit of 8191 bytes for the maximum size of the argument.
+  Note: do not pass sizeof(type) type into _IOR/IOW, as that will lead
+  to encoding sizeof(sizeof(type)), i.e. sizeof(size_t).
+
+
+Interface versions
+==================
+
+Some subsystems use version numbers in data structures to overload
+commands with different interpretations of the argument.
+
+This is generally a bad idea, since changes to existing commands tend
+to break existing applications.
+
+A better approach is to add a new ioctl command with a new number. The
+old command still needs to be implemented in the kernel for compatibility,
+but this can be a wrapper around the new implementation.
+
+Return code
+===========
+
+ioctl commands can return negative error codes as documented in errno(3),
+these get turned into errno values in user space. On success, the return
+code should be zero. It is also possible but not recommended to return
+a positive 'long' value.
+
+When the ioctl callback is called with an unknown command number, the
+handler returns either -ENOTTY or -ENOIOCTLCMD, which also results in
+-ENOTTY being returned from the system call. Some subsystems return
+-ENOSYS or -EINVAL here for historic reasons, but this is wrong.
+
+Prior to Linux-5.5, compat_ioctl handlers were required to return
+-ENOIOCTLCMD in order to use the fallback conversion into native
+commands. As all subsystems are now responsible for handling compat
+mode themselves, this is no longer needed, but it may be important to
+consider when backporting bug fixes to older kernels.
+
+Timestamps
+==========
+
+Traditionally, timestamps and timeout values are passed as ``struct
+timespec`` or ``struct timeval``, but these are problematic because of
+incompatible definitions of these structures in user space after the
+move to 64-bit time_t.
+
+The __kernel_timespec type can be used instead to be embedded in other
+data structures when separate second/nanosecond values are desired,
+or passed to user space directly. This is still not ideal though,
+as the structure matches neither the kernel's timespec64 nor the user
+space timespec exactly. The get_timespec64() and put_timespec64() helper
+functions canbe used to ensure that the layout remains compatible with
+user space and the padding is treated correctly.
+
+As it is cheap to convert seconds to nanoseconds, but the opposite
+requires an expensive 64-bit division, a simple __u64 nanosecond value
+can be simpler and more efficient.
+
+Timeout values and timestamps should ideally use CLOCK_MONOTONIC time,
+as returned by ``ktime_get_ns()`` or ``ktime_get_ts64()``.  Unlike
+CLOCK_REALTIME, this makes the timestamps immune from jumping backwards
+or forwards due to leap second adjustments and clock_settime() calls.
+
+``ktime_get_real_ns()`` can be used for CLOCK_REALTIME timestamps that
+may be required for timestamps that need to be persistent across a reboot
+or between multiple machines.
+
+32-bit compat mode
+==================
+
+In order to support 32-bit user space running on a 64-bit machine, each
+subsystem or driver that implements an ioctl callback handler must also
+implement the corresponding compat_ioctl handler.
+
+As long as all the rules for data structures are followed, this is as
+easy as setting the .compat_ioctl pointer to a helper function such as
+``compat_ptr_ioctl()`` or ``blkdev_compat_ptr_ioctl``.
+
+compat_ptr()
+------------
+
+On the s/390 architecture, 31-bit user space has ambiguous representations
+for data pointers, with the upper bit being ignored. When running such
+a process in compat mode, the ``compat_ptr()`` helper must be used to
+clear the upper bit of a compat_uptr_t and turn it into a valid 64-bit
+pointer.  On other architectures, this macro only performs a cast to a
+``void __user *`` pointer.
+
+In an compat_ioctl() callback, the last argument is an unsigned long,
+which can be interpreted as either a pointer or a scalar depending on
+the command. If it is a scalar, then compat_ptr() must not be used, to
+ensure that the 64-bit kernel behaves the same way as a 32-bit kernel
+for arguments with the upper bit set.
+
+The compat_ptr_ioctl() helper can be used in place of a custom
+compat_ioctl file operation for drivers that only take arguments that
+are pointers to compatible data structures.
+
+Structure layout
+----------------
+
+Compatible data structures have the same layout on all architectures,
+avoiding all problematic members:
+
+* ``long`` and ``unsigned long`` are the size of a register, so
+  they can be either 32 bit or 64 bit wide and cannot be used in portable
+  data structures. Fixed-length replacements are ``__s32``, ``__u32``,
+  ``__s64`` and ``__u64``.
+
+* Pointers have the same problem, in addition to requiring the
+  use of ``compat_ptr()``. The best workaround is to use ``__u64``
+  in place of pointers, which requires a cast to ``uintptr_t`` in user
+  space, and the use of ``u64_to_user_ptr()`` in the kernel to convert
+  it back into a user pointer.
+
+* On the x86-32 (i386) architecture, the alignment of 64-bit variables
+  is only 32 bit, but they are naturally aligned on most other
+  architectures including x86-64. This means a structure like
+
+  ::
+
+    struct foo {
+        __u32 a;
+        __u64 b;
+        __u32 c;
+    };
+
+  has four bytes of padding between a and b on x86-64, plus another four
+  bytes of padding at the end, but no padding on i386, and it needs a
+  compat_ioctl conversion handler to translate between the two formats.
+
+  To avoid this problem, all structures should have their members
+  naturally aligned, or explicit reserved fields added in place of the
+  implicit padding.
+
+* On ARM OABI user space, 16-bit member variables have 32-bit
+  alignment, making them incompatible with modern EABI kernels.
+  Conversely, on the m68k architecture, all struct members have at most
+  16-bit alignment. These rarely cause problems as neither ARM-OABI nor
+  m68k are supported by any compat mode, but for consistency, it is best
+  to completely avoid 16-bit member variables.
+
+
+* Bitfields and enums generally work as one would expect them to,
+  but some properties of them are implementation-defined, so it is better
+  to avoid them completely in ioctl interfaces.
+
+* ``char`` members can be either signed or unsigned, depending on
+  the architecture, so the __u8 and __s8 types should be used for 8-bit
+  integer values, though char arrays are clearer for fixed-length strings.
+
+Information leaks
+=================
+
+Uninitialized data must not be copied back to user space, as this can
+cause an information leak, which can be used to defeat kernel address
+space layout randomization (KASLR), helping in an attack.
+
+As explained for the compat mode, it is best to not avoid any padding in
+data structures, but if there is already padding in existing structures,
+the kernel driver must be careful to zero out the padding using
+``memset()`` or similar before copying it to user space.
+
+Subsystem abstractions
+======================
+
+While some device drivers implement their own ioctl function, most
+subsystems implement the same command for multiple drivers.  Ideally the
+subsystem has an .ioctl() handler that copies the arguments from and
+to user space, passing them into subsystem specific callback functions
+through normal kernel pointers.
+
+This helps in various ways:
+
+* Applications written for one driver are more likely to work for
+  another one in the same subsystem if there are no subtle differences
+  in the user space ABI.
+
+* The complexity of user space access and data structure layout at done
+  in one place, reducing the potential for implementation bugs.
+
+* It is more likely to be reviewed by experienced developers
+  that can spot problems in the interface when the ioctl is shared
+  between multiple drivers than when it is only used in a single driver.
+
+Alternatives to ioctl
+=====================
+
+There are many cases in which ioctl is not the best solution for a
+problem. Alternatives include
+
+* System calls are a better choice for a system-wide feature that
+  is not tied to a physical device or constrained by the file system
+  permissions of a character device node
+
+* netlink is the preferred way of configuring any network related
+  objects through sockets.
+
+* debugfs is used for ad-hoc interfaces for debugging functionality
+  that does not need to be exposed as a stable interface to applications.
+
+* sysfs is a good way to expose the state of an in-kernel object
+  that is not tied to a file descriptor.
+
+* configfs can be used for more complex configuration than sysfs
+
+* A custom file system can provide extra flexibility with a simple
+  user interface but add a lot of complexity in the implementation.
-- 
2.20.0

