Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA30AC2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8479922B48
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 10:56:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbfLLK4j (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 05:56:39 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:48485 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728410AbfLLK4i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 05:56:38 -0500
Received: from mail-qk1-f181.google.com ([209.85.222.181]) by
 mrelayeu.kundenserver.de (mreue009 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MD9Kj-1iWroo1GOP-009AXJ; Thu, 12 Dec 2019 11:56:35 +0100
Received: by mail-qk1-f181.google.com with SMTP id w127so1199910qkb.11;
        Thu, 12 Dec 2019 02:56:35 -0800 (PST)
X-Gm-Message-State: APjAAAVo+KsHOoDacGvNKESGyItj7pqI4j4sMM+vMXUhc3kBQ918vnol
        0h0DWVRL6zJuL6aMHTydCTX4jfkYHXUZxDbCzTQ=
X-Google-Smtp-Source: APXvYqyndrbkmofDjRfvJjg927uqlTWgSwrDxi6l8oY4GHQTxso0dAORyZL07Delnlw8+g2sp9ETnlRQAbsxTzYfdPs=
X-Received: by 2002:a05:620a:a5b:: with SMTP id j27mr7482041qka.286.1576148193908;
 Thu, 12 Dec 2019 02:56:33 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-25-arnd@arndb.de>
 <20191211140551.00520269@lwn.net>
In-Reply-To: <20191211140551.00520269@lwn.net>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 11:56:17 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1qAkGwCNw8hyd7y1eRyfzZuLR214V9fpt+MdDEeAjEnA@mail.gmail.com>
Message-ID: <CAK8P3a1qAkGwCNw8hyd7y1eRyfzZuLR214V9fpt+MdDEeAjEnA@mail.gmail.com>
Subject: Re: [PATCH 24/24] Documentation: document ioctl interfaces better
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Daniel Vetter <daniel@ffwll.ch>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:xtxvUGCIIamgDh0SVaYbGMMyb2QsEvxCXQTZ5rK1LesDfZWCjlf
 lrxC2umg6y+6nZV966Aj8auAp2eeiTJDYHtTMJ4EapcVQPm2+KSGSsdqvICmRPt68DmwoYO
 c5+Og4aAxSsC3ES4z9Ff3AKQxyTKUkCbn/IoBEKG5MzOGXg6fJH2wn8WRI/bGJKzoeG0GcK
 Q7TwylMjrcsH5eSh9ZKQQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:dQKU74OQMJo=:glM8M0jUtcBwIe9Wgo2U6B
 RoZmJd+UrMnGeXBQG4XYnFQS+hY0ozLq4wHgZ8rsb4Ayd0ox8qLDg3MqN3LarYqZ8Kjkn6soB
 8GweBo+UfieRcPioDh8w2zG+47wsBhCq8SQqdfa1+/i+6bKPDqW+WpBjasR6XwMTJVZMFZ6FE
 cda+0wpKBBsRDe4V35TgMEPUeF81nq/kK7J3CWqTPiXd717Y8iWsvw5Swq6Fgmw597MzYAWWA
 b+ZDWvufrDwLOXujhCE27GTsfd0lrfaSh0AXOt9DGWaNrU8va6L8VaLCJhD7KCp9aiyaDOsFk
 PjjBUWcyOdxFDYytS2G5BPsKBaAA3lSmDqZoVotE0NqqwiuTEUyx+q5T/EtJ4CnQB/34gLhIy
 GmMuD+OWOZbwDM+CRDERwKdSYrh7XGhB4ziEK1ZVNwSrBZPgUcN2oZTfudrgpmsZ9FWW8y5m7
 Q5TjyWG0zG4gRsY1pKKhJQ6y1OErMNmPVXv4+ENzFT26nghKMKvVtMk+WZi2uBdi/umkEWb5f
 euhiFdBinU0fdrxgbgxhaghTwunVdMW2P0u4i6yFaUOEv1w8SRwIoGPTkrxe1aL5QTkEJTxiK
 agbpJ/qXNVr7RR7vRUSQKr3zWXjQmKUar0a12ny+w7bmdFozICQ1F6exKMBzdBatojf7XEZZG
 0nbej+6OBI7oKePguFVrz3bEY2oX6VX5QLkHn4HJbgikfpzRgmjlRZM70O2ebgTRuZPLlQHRx
 2JuAb364l0VWEuOd2y260INcviNbvLf89goXYde9Gg2T09XimpolowkRKKh2V5Cz8TF/8FKeI
 qnfmq+5oShfVN+3jb54NUbfOALFoSaM8KlO/B739uZk8WSuzzw9eTAC2orchOzqKW9m93ordr
 h8GH3l9SHctUDcf0VY+A==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 11, 2019 at 10:05 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Wed, 11 Dec 2019 21:42:58 +0100
> Arnd Bergmann <arnd@arndb.de> wrote:
>
> > Documentation/process/botching-up-ioctls.rst was orignally
> > written as a blog post for DRM driver writers, so it it misses
> > some points while going into a lot of detail on others.
> >
> > Try to provide a replacement that addresses typical issues
> > across a wider range of subsystems, and follows the style of
> > the core-api documentation better.
> >
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> Thanks for improving the docs!  I have a few nits outside of the content
> itself.
>
> >  Documentation/core-api/index.rst |   1 +
> >  Documentation/core-api/ioctl.rst | 250 +++++++++++++++++++++++++++++++
> >  2 files changed, 251 insertions(+)
> >  create mode 100644 Documentation/core-api/ioctl.rst
>
> So you left the old document in place; was that intentional?

I wasn't quite sure what to do with it. It does have some points that
are relevant for drivers/gpu/drm that I did not cover in the new document.

Maybe Daniel has an idea for how the two documents can be combined
now, or the overlap reduced.

> > diff --git a/Documentation/core-api/index.rst b/Documentation/core-api/index.rst
> > index ab0eae1c153a..3f28b2f668be 100644
> > --- a/Documentation/core-api/index.rst
> > +++ b/Documentation/core-api/index.rst
> > @@ -39,6 +39,7 @@ Core utilities
> >     ../RCU/index
> >     gcc-plugins
> >     symbol-namespaces
> > +   ioctl
> >
> >
> >  Interfaces for kernel debugging
> > diff --git a/Documentation/core-api/ioctl.rst b/Documentation/core-api/ioctl.rst
> > new file mode 100644
> > index 000000000000..cb2c86ae63e7
> > --- /dev/null
> > +++ b/Documentation/core-api/ioctl.rst
> > @@ -0,0 +1,250 @@
> > +======================
> > +ioctl based interfaces
> > +======================
> > +
> > +:c:func:`ioctl` is the most common way for applications to interface
>
> Please don't use :c:func: anymore.  If you just say "ioctl()" the right
> thing will happen (which is nothing here, since there isn't anything that
> makes sense to link to in the internal kernel context).
>
> We need a checkpatch rule for :c:func: I guess.

Ok, fixed.

> Similarly, later on you have:
>
> > +Timeout values and timestamps should ideally use CLOCK_MONOTONIC time,
> > +as returned by ``ktime_get_ns()`` or ``ktime_get_ts64()``.  Unlike
> > +CLOCK_REALTIME, this makes the timestamps immune from jumping backwards
> > +or forwards due to leap second adjustments and clock_settime() calls.
>
> Making those functions ``literal`` will defeat the automatic
> cross-referencing.  Better to just say ktime_get_ns() without quotes.

Ok, done.

Does this only work for function names, or should I also use a different way to
write ``include/uapi/asm-generic/ioctl.h`` or ``sizeof(size)`` and
``unsigned long``

> [...]
>
> > +* On the x86-32 (i386) architecture, the alignment of 64-bit variables
> > +  is only 32 bit, but they are naturally aligned on most other
> > +  architectures including x86-64. This means a structure like
> > +
> > +  ::
>
> You don't need the extra lines here; just say "...a structure like::"

Done. See below for changes I did relative to the feedback so far,
now squashed into the latest version.

Thanks for the review,

         Arnd

8<-----------
diff --git a/Documentation/core-api/ioctl.rst b/Documentation/core-api/ioctl.rst
index cb2c86ae63e7..2e70d3633883 100644
--- a/Documentation/core-api/ioctl.rst
+++ b/Documentation/core-api/ioctl.rst
@@ -2,7 +2,7 @@
 ioctl based interfaces
 ======================

-:c:func:`ioctl` is the most common way for applications to interface
+ioctl() is the most common way for applications to interface
 with device drivers. It is flexible and easily extended by adding new
 commands and can be passed through character devices, block devices as
 well as sockets and other special file descriptors.
@@ -20,19 +20,19 @@ identifies an action for a particular driver,
there are a number of
 conventions around defining them.

 ``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
-ioctl commands that follow modern conventions: ``_IOC``, ``_IOR``,
+ioctl commands that follow modern conventions: ``_IO``, ``_IOR``,
 ``_IOW``, and ``_IORW``. These should be used for all new commands,
 with the correct parameters:

 _IO/_IOR/_IOW/_IOWR
    The macro name determines whether the argument is used for passing
    data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is
-   not a pointer (_IOC). It is possible but not recommended to pass an
-   integer value instead of a pointer with _IOC.
+   not a pointer (_IO). It is possible but not recommended to pass an
+   integer value instead of a pointer with _IO.

 type
    An 8-bit number, often a character literal, specific to a subsystem
-   or driver, and listed in :doc:`../ioctl/ioctl-number`
+   or driver, and listed in :doc:`../userspace-api/ioctl/ioctl-number`

 nr
   An 8-bit number identifying the specific command, unique for a give
@@ -91,7 +91,7 @@ data structures when separate second/nanosecond
values are desired,
 or passed to user space directly. This is still not ideal though,
 as the structure matches neither the kernel's timespec64 nor the user
 space timespec exactly. The get_timespec64() and put_timespec64() helper
-functions canbe used to ensure that the layout remains compatible with
+functions can be used to ensure that the layout remains compatible with
 user space and the padding is treated correctly.

 As it is cheap to convert seconds to nanoseconds, but the opposite
@@ -99,13 +99,12 @@ requires an expensive 64-bit division, a simple
__u64 nanosecond value
 can be simpler and more efficient.

 Timeout values and timestamps should ideally use CLOCK_MONOTONIC time,
-as returned by ``ktime_get_ns()`` or ``ktime_get_ts64()``.  Unlike
+as returned by ktime_get_ns() or ktime_get_ts64().  Unlike
 CLOCK_REALTIME, this makes the timestamps immune from jumping backwards
 or forwards due to leap second adjustments and clock_settime() calls.

-``ktime_get_real_ns()`` can be used for CLOCK_REALTIME timestamps that
-may be required for timestamps that need to be persistent across a reboot
-or between multiple machines.
+ktime_get_real_ns() can be used for CLOCK_REALTIME timestamps that
+need to be persistent across a reboot or between multiple machines.

 32-bit compat mode
 ==================
@@ -116,14 +115,14 @@ implement the corresponding compat_ioctl handler.

 As long as all the rules for data structures are followed, this is as
 easy as setting the .compat_ioctl pointer to a helper function such as
-``compat_ptr_ioctl()`` or ``blkdev_compat_ptr_ioctl``.
+compat_ptr_ioctl() or blkdev_compat_ptr_ioctl().

 compat_ptr()
 ------------

 On the s/390 architecture, 31-bit user space has ambiguous representations
 for data pointers, with the upper bit being ignored. When running such
-a process in compat mode, the ``compat_ptr()`` helper must be used to
+a process in compat mode, the compat_ptr() helper must be used to
 clear the upper bit of a compat_uptr_t and turn it into a valid 64-bit
 pointer.  On other architectures, this macro only performs a cast to a
 ``void __user *`` pointer.
@@ -150,16 +149,14 @@ avoiding all problematic members:
   ``__s64`` and ``__u64``.

 * Pointers have the same problem, in addition to requiring the
-  use of ``compat_ptr()``. The best workaround is to use ``__u64``
+  use of compat_ptr(). The best workaround is to use ``__u64``
   in place of pointers, which requires a cast to ``uintptr_t`` in user
-  space, and the use of ``u64_to_user_ptr()`` in the kernel to convert
+  space, and the use of u64_to_user_ptr() in the kernel to convert
   it back into a user pointer.

 * On the x86-32 (i386) architecture, the alignment of 64-bit variables
-  is only 32 bit, but they are naturally aligned on most other
-  architectures including x86-64. This means a structure like
-
-  ::
+  is only 32-bit, but they are naturally aligned on most other
+  architectures including x86-64. This means a structure like::

     struct foo {
         __u32 a;
@@ -177,9 +174,10 @@ avoiding all problematic members:

 * On ARM OABI user space, 16-bit member variables have 32-bit
   alignment, making them incompatible with modern EABI kernels.
-  Conversely, on the m68k architecture, all struct members have at most
-  16-bit alignment. These rarely cause problems as neither ARM-OABI nor
-  m68k are supported by any compat mode, but for consistency, it is best
+  Conversely, on the m68k architecture, struct members are not
+  guaranteed to have an alignment greater than 16-bit.
+  These rarely cause problems as neither ARM-OABI nor m68k are
+  supported by any compat mode, but for consistency, it is best
   to completely avoid 16-bit member variables.


@@ -198,10 +196,10 @@ Uninitialized data must not be copied back to
user space, as this can
 cause an information leak, which can be used to defeat kernel address
 space layout randomization (KASLR), helping in an attack.

-As explained for the compat mode, it is best to not avoid any padding in
-data structures, but if there is already padding in existing structures,
-the kernel driver must be careful to zero out the padding using
-``memset()`` or similar before copying it to user space.
+As explained for the compat mode, it is best to not avoid any implicit
+padding in data structures, but if there is already padding in existing
+structures, the kernel driver must be careful to zero out the padding
+using memset() or similar before copying it to user space.

 Subsystem abstractions
 ======================
@@ -218,7 +216,7 @@ This helps in various ways:
   another one in the same subsystem if there are no subtle differences
   in the user space ABI.

-* The complexity of user space access and data structure layout at done
+* The complexity of user space access and data structure layout is done
   in one place, reducing the potential for implementation bugs.

 * It is more likely to be reviewed by experienced developers
@@ -247,4 +245,4 @@ problem. Alternatives include
 * configfs can be used for more complex configuration than sysfs

 * A custom file system can provide extra flexibility with a simple
-  user interface but add a lot of complexity in the implementation.
+  user interface but add a lot of complexity to the implementation.
