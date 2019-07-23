Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D8E1C7618B
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:18:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794EC21921
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 11:18:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389292AbfGWLSu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 07:18:50 -0400
Received: from smtprelay0108.hostedemail.com ([216.40.44.108]:54048 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbfGWLSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:18:49 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 8194F100E86C1;
        Tue, 23 Jul 2019 11:18:48 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: rail43_69daedcfa5b08
X-Filterd-Recvd-Size: 4704
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf09.hostedemail.com (Postfix) with ESMTPA;
        Tue, 23 Jul 2019 11:18:47 +0000 (UTC)
Message-ID: <8016ee9b5ee38fae0c782420ca449f863270cca9.camel@perches.com>
Subject: Re: get_maintainers.pl subsystem output
From:   Joe Perches <joe@perches.com>
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Duda, Sebastian" <sebastian.duda@fau.de>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Ramsauer <ralf.ramsauer@oth-regensburg.de>,
        Wolfgang Mauerer <wolfgang.mauerer@oth-regensburg.de>
Date:   Tue, 23 Jul 2019 04:18:45 -0700
In-Reply-To: <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
         <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
         <2835dfa18922905ffabafb11fca7e1d2@fau.de>
         <CAKXUXMwfd133rv0bMert-BBftaqxxr_93dUHpaUjEwE8RE_wwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-0ubuntu0.18.10.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-07-23 at 10:42 +0200, Lukas Bulwahn wrote:
> On Tue, Jul 23, 2019 at 9:30 AM Duda, Sebastian <sebastian.duda@fau.de> wrote:
> > when analyzing the patch
> > `<20150128012747.824898918@linuxfoundation.org>` [1] with
> > `get_maintainers.pl --subsystem --status --separator , /tmp/patch`,
> > there is the following output:
> > 
> >      Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM),Josef Bacik
> > <jbacik@fb.com> (maintainer:BTRFS FILE SYSTEM),David Sterba
> > <dsterba@suse.cz> (maintainer:BTRFS FILE SYSTEM),Alexander Viro
> > <viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and
> > infrastructure)),"Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE
> > SYSTEM),Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE
> > SYSTEM),Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE
> > SYSTEM),Changman Lee <cm224.lee@samsung.com> (maintainer:F2FS FILE
> > SYSTEM),Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM
> > IN USERSPACE),Steven Whitehouse <swhiteho@redhat.com> (supporter:GFS2
> > FILE SYSTEM),Anton Altaparmakov <anton@tuxera.com> (supporter:NTFS
> > FILESYSTEM),Hugh Dickins <hughd@google.com> (maintainer:TMPFS (SHMEM
> > FILESYSTEM)),linux-btrfs@vger.kernel.org (open list:BTRFS FILE
> > SYSTEM),linux-kernel@vger.kernel.org (open
> > list),linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and
> > infrastructure)),linux-ext4@vger.kernel.org (open list:EXT4 FILE
> > SYSTEM),linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE
> > SYSTEM),fuse-devel@lists.sourceforge.net (open list:FUSE: FILESYSTEM IN
> > USERSPACE),cluster-devel@redhat.com (open list:GFS2 FILE
> > SYSTEM),linux-ntfs-dev@lists.sourceforge.net (open list:NTFS
> > FILESYSTEM),linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
> >      Maintained,Buried alive in reporters,Supported
> >      BTRFS FILE SYSTEM,THE REST,FILESYSTEMS (VFS and infrastructure),EXT4
> > FILE SYSTEM,F2FS FILE SYSTEM,FUSE: FILESYSTEM IN USERSPACE,GFS2 FILE
> > SYSTEM,NTFS FILESYSTEM,MEMORY MANAGEMENT,TMPFS (SHMEM FILESYSTEM)
> > 
> > How can I parse this output automatically? or how can I generate a
> > parsable output?
[]
> > I need the tuples of subsystems and status:
> > (THE REST, Buried alive in reporters)
> > (TMPFS, Maintained)
> > (BTRFS FILE SYSTEM, Maintained)
> > …
> > (GFS2 FILE SYSTEM, Supported)
> > 
> > I'm not aware how to reliably assign the statuses to the subsystems.

Again, run the script using the individual files
contained in a patch
instead of the entire patch.

I again suggest using gnu parallel.

> Joe, I hope this example makes more clear what and how Sebastian would
> actually like to have the information from the MAINTAINERS file
> presented for our use case. Currently, we would consider
> get_maintainer.pl to be the proper place for such a feature in the
> upstream development.

I believe I understand how you want to use
the get_maintainer script output.

> Joe, would you support and would you accept if we extend
> get_maintainer.pl to provide output of the status in such a way that
> the status output can be clearly mapped to the subsystem?

Not really, no.  I don't see much value in your
request to others.  It seems you are doing some
academic work rather than actually using it for
sending patches.

You are of course welcome to extexd the script
in whatever manner you need for your own use,
but even here, I don't believe you need to do
anything to the script but change how you use it.



