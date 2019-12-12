Return-Path: <SRS0=kgnc=2C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1F10C2D0C8
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78F5F2077B
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Dec 2019 11:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728861AbfLLLFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Dec 2019 06:05:11 -0500
Received: from mout.kundenserver.de ([217.72.192.73]:40217 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbfLLLFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Dec 2019 06:05:11 -0500
Received: from mail-qt1-f180.google.com ([209.85.160.180]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.145]) with ESMTPSA (Nemesis)
 id 1N8nrc-1hc82N0iU2-015pgV; Thu, 12 Dec 2019 12:05:09 +0100
Received: by mail-qt1-f180.google.com with SMTP id k40so219830qtk.8;
        Thu, 12 Dec 2019 03:05:08 -0800 (PST)
X-Gm-Message-State: APjAAAUM2PgCkhu40B0eHSm0jZcOQhKOjoGg7pzw/fdOlBGxS9G/gTEN
        HxnYrUC3SB+1VX87hoG0/NRxTLs/NZJ1GpPck9I=
X-Google-Smtp-Source: APXvYqz+DjQKwVb8onI5Bl4766PLexZ3Eyfl8bPq4KpH+pqHQ2QRIW4i+Ool5tGKrQv0opx42ZAqs07sNWCKoD7h4s0=
X-Received: by 2002:ac8:47d3:: with SMTP id d19mr6784581qtr.142.1576148707982;
 Thu, 12 Dec 2019 03:05:07 -0800 (PST)
MIME-Version: 1.0
References: <20191211204306.1207817-1-arnd@arndb.de> <20191211204306.1207817-25-arnd@arndb.de>
 <CAMuHMdW=eG9WWbeL0Od6dVzE7ydpBvVybvkn+cGFtyBR77sP6A@mail.gmail.com>
In-Reply-To: <CAMuHMdW=eG9WWbeL0Od6dVzE7ydpBvVybvkn+cGFtyBR77sP6A@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 12 Dec 2019 12:04:51 +0100
X-Gmail-Original-Message-ID: <CAK8P3a0z2c4GCs0NOcsUA_FFiBJ3OhF5HXawZFJZzNH2cck=mg@mail.gmail.com>
Message-ID: <CAK8P3a0z2c4GCs0NOcsUA_FFiBJ3OhF5HXawZFJZzNH2cck=mg@mail.gmail.com>
Subject: Re: [PATCH 24/24] Documentation: document ioctl interfaces better
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Jens Axboe <axboe@kernel.dk>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:7aEUDq6DygRVQNOBeY23McUss7Srp0M8N4hLzUOLofAyxIcqSHR
 refNKKPuQ6VP25E5alP3H9d1+LnlqpQoiCY6KzmF1Xb94PurPBz+X9dLSl5HnnilUdHGuZ/
 g5m5YzjgrFr8fzNNHCws6J0x2v9ZKYL60iyNMzG7Ktfp5EZNvvghmfWaL26WXd7+reJgc1i
 DJzAVAZm/lSxZmkaZ1eoQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7VsM8gjWTuQ=:LTVuyS28GKNW3aAoa54dLl
 oaSzXZfYub4B7nYhm7So84qBF+IY+7G+WcUx6qfjDGxGIob9AIgE3tj/fgd4YfvF78Nas3j03
 Wj8d2DmpUw6dRM3GwQBAnPojO5MimY7pxSBily/les0WnxKGvScIYgZpWEZ21Fb9+BwevSG2q
 6KkOzbHAkGltLvJhxOwzKBOrpFMj5iKVpZ1C+xCWElMqLETA8p0Ot/tzdVIBVy5e7z4mWAyfv
 d9g0xR5v2BzUvnbVE4V5bZG4ogNpsUJwehLa2jWOOwXBIXQV3DosVydcZlLQdh9hza6qGSPtz
 diWV/qVt7SVInNHnYO8uOhc26nSenVCR4zg8lzMYGpY409uIGxgmBegj8jlMwbWsTr9g6u9X6
 gI6LJ1teKErexn+02ZC2j1bybhx0+Km9MQwG2+x7nlqg4GrtMumoNWzSPJZi5WXUc6spdrtPW
 GOvX8vEVRy1V8SaPbIcCrCsy+698/Xwl/UGIL8BI/tUhgrSCJFEvejBvRrWsu32dF13rFyOmH
 vPJuZuiQXHReICeQWfYcODmJFYxKRx+MpNctmM2iKOd5hcqrfHb9F5tP1Dh5h/fnhfC419mcd
 eFJ36PN/zGxHILJg64sINzgWIsVq/e+UYBpCl2+0pTSEBOeD+YRie+612PVIkViSbkML9WPOc
 DReNerTfe7ri75unH2R5Xqlbs5xE/n4BOKrJ5ZjINHaFQRDGasK3ggg7lqBDzDTiJN02Pg2VB
 9abfqYnQ2I8yK5uwM0ismMiAyZGvbvc2uNH02fWEpLoJ2f/6LuiS3YP0MlgCSdXD0bh6nIPoT
 WCDpfe6s8zLfHDjUWJhIm7TK0bj8zQG9eGBvQc9Ag19+4Xt8LOjS7liACW1EOk2EYkIxKZiNI
 PK4dReHxFgGK9vF/NBLg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 12, 2019 at 9:16 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Dec 11, 2019 at 9:53 PM Arnd Bergmann <arnd@arndb.de> wrote:
> > +``include/uapi/asm-generic/ioctl.h`` provides four macros for defining
> > +ioctl commands that follow modern conventions: ``_IOC``, ``_IOR``,
> > +``_IOW``, and ``_IORW``. These should be used for all new commands,
> > +with the correct parameters:
> > +
> > +_IO/_IOR/_IOW/_IOWR
>
> This says _IO....
>
> > +   The macro name determines whether the argument is used for passing
> > +   data into kernel (_IOW), from the kernel (_IOR), both (_IOWR) or is
>
> into the kernel
> , or is
>
> > +   not a pointer (_IOC). It is possible but not recommended to pass an
> > +   integer value instead of a pointer with _IOC.
>
> ...which is not explained here, but _IOC is?

I mean _IO() everywhere, I would consider _IOC an implementation
detail and not document that here.

s/_IOC/_IO/ throughout the document now.

> > +size
> > +  The name of the data type pointed to by the argument, the command
> > +  number encodes the ``sizeof(size)`` value in a 13-bit or 14-bit integer,
> > +  leading to a limit of 8191 bytes for the maximum size of the argument.
> > +  Note: do not pass sizeof(type) type into _IOR/IOW, as that will lead
> > +  to encoding sizeof(sizeof(type)), i.e. sizeof(size_t).
>
> Looks like "size" could be renamed, to make this more obvious?

Changed to data_type now, which is what I found in some other
documentation.


> > +space timespec exactly. The get_timespec64() and put_timespec64() helper
> > +functions canbe used to ensure that the layout remains compatible with
>
> can be

done.

> > +
> > +``ktime_get_real_ns()`` can be used for CLOCK_REALTIME timestamps that
> > +may be required for timestamps that need to be persistent across a reboot
>
> Drop "may be required for timestamps that"?

done.

> > +* ``long`` and ``unsigned long`` are the size of a register, so
> > +  they can be either 32 bit or 64 bit wide and cannot be used in portable
>
> 32-bit or 64-bit (for consistency with the rest of the document)

The convention I was trying to follow is to write

"32-bit userspace" or "32-bit processor"

but

"this type is 32 bit wide"

I wasn't consistent though, changed it now as you suggested.

> > +
> > +* On ARM OABI user space, 16-bit member variables have 32-bit
> > +  alignment, making them incompatible with modern EABI kernels.
> > +  Conversely, on the m68k architecture, all struct members have at most
> > +  16-bit alignment. These rarely cause problems as neither ARM-OABI nor
>
> "have at most 16-bit alignment" sounds a bit weird to me, as a member
> may have a greater alignment.
> "struct members are not guaranteed to have an alignment greater than 16-bit"?

done.

> > +
> > +As explained for the compat mode, it is best to not avoid any padding in
>
> best to avoid any implicit padding?

done.

> > +
> > +* The complexity of user space access and data structure layout at done
>
> is done

changed

> > +There are many cases in which ioctl is not the best solution for a
> > +problem. Alternatives include
>
> :

done

> > +* System calls are a better choice for a system-wide feature that
> > +  is not tied to a physical device or constrained by the file system
> > +  permissions of a character device node
> > +
> > +* netlink is the preferred way of configuring any network related
> > +  objects through sockets.
> > +
> > +* debugfs is used for ad-hoc interfaces for debugging functionality
> > +  that does not need to be exposed as a stable interface to applications.
> > +
> > +* sysfs is a good way to expose the state of an in-kernel object
> > +  that is not tied to a file descriptor.
> > +
> > +* configfs can be used for more complex configuration than sysfs
> > +
> > +* A custom file system can provide extra flexibility with a simple
> > +  user interface but add a lot of complexity in the implementation.
>
> adds ... to

done.

Thanks for all the suggestions!

      Arnd
