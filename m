Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2B8C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:30:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6BF21911
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:30:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=fau.de header.i=@fau.de header.b="UFpzkT8O"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388365AbfGWHaG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:30:06 -0400
Received: from mx-rz-3.rrze.uni-erlangen.de ([131.188.11.22]:50693 "EHLO
        mx-rz-3.rrze.uni-erlangen.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388285AbfGWHaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:30:05 -0400
Received: from mx-rz-smart.rrze.uni-erlangen.de (mx-rz-smart.rrze.uni-erlangen.de [IPv6:2001:638:a000:1025::1e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by mx-rz-3.rrze.uni-erlangen.de (Postfix) with ESMTPS id 45t99Q5DDmz1xn3;
        Tue, 23 Jul 2019 09:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fau.de; s=fau-2013;
        t=1563867002; bh=13skyY+ZGLpqMmcP07B5MdUor/CZCIhEq8X/nTHu8wk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From:To:CC:
         Subject;
        b=UFpzkT8O6jU+vkvYRN06CvtUKBIzSfbypP5IJza10HsfrUsjc/bWJuNSIBxp5UgOY
         dgnhAbRxys4Jnr4RdMtSTmhWLJfI7iv5kc41uiDPOIPQYBnR+257ZIuMP3Cb1jICI6
         iJv6l8r4QPB3vLXbHJfIW/v9BOdREbyvTIXvlEWsFzSMBLnx5d8xPoajU2lfABUIM8
         bh38cpBOW9P6aw6qK3esExvs8YJdjwXvkWeY8yIiKU3SxIwsRvPAglfllXDr6Rscoa
         nN8aSw31Y1IGqwgdiIZgQrUE63JJwAZ1BOX5a7eWVsWfrCqVaeOyp9XBjltzqdbOXX
         ySmKj2dlIPMkA==
X-Virus-Scanned: amavisd-new at boeck2.rrze.uni-erlangen.de (RRZE)
X-RRZE-Flag: Not-Spam
X-RRZE-Submit-IP: 131.188.11.37
Received: from faumail.fau.de (smtp-auth.uni-erlangen.de [131.188.11.37])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: U2FsdGVkX1+rhsFEdpRx6XmGg/iUkhy/LK3IVpIIbvI=)
        by smtp-auth.uni-erlangen.de (Postfix) with ESMTPSA id 45t99M5qQRz1yQ0;
        Tue, 23 Jul 2019 09:29:59 +0200 (CEST)
Received: from kUd8DOJMh/hOHCE3o9CDi9/jEtWv6tTVqEMd9jr5svE=
 by faumail.uni-erlangen.de
 with HTTP (HTTP/1.1 POST); Tue, 23 Jul 2019 09:29:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Tue, 23 Jul 2019 09:29:59 +0200
From:   "Duda, Sebastian" <sebastian.duda@fau.de>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, lukas.bulwahn@gmail.com,
        ralf.ramsauer@oth-regensburg.de, wolfgang.mauerer@oth-regensburg.de
Subject: Re: get_maintainers.pl subsystem output
In-Reply-To: <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
References: <2c912379f96f502080bfcc79884cdc35@fau.de>
 <5a468c6cbba8ceeed6bbeb8d19ca2d46cb749a47.camel@perches.com>
Message-ID: <2835dfa18922905ffabafb11fca7e1d2@fau.de>
X-Sender: sebastian.duda@fau.de
User-Agent: Roundcube Webmail/1.2.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joe,

when analyzing the patch 
`<20150128012747.824898918@linuxfoundation.org>` [1] with 
`get_maintainers.pl --subsystem --status --separator , /tmp/patch`, 
there is the following output:

     Chris Mason <clm@fb.com> (maintainer:BTRFS FILE SYSTEM),Josef Bacik 
<jbacik@fb.com> (maintainer:BTRFS FILE SYSTEM),David Sterba 
<dsterba@suse.cz> (maintainer:BTRFS FILE SYSTEM),Alexander Viro 
<viro@zeniv.linux.org.uk> (maintainer:FILESYSTEMS (VFS and 
infrastructure)),"Theodore Ts'o" <tytso@mit.edu> (maintainer:EXT4 FILE 
SYSTEM),Andreas Dilger <adilger.kernel@dilger.ca> (maintainer:EXT4 FILE 
SYSTEM),Jaegeuk Kim <jaegeuk@kernel.org> (maintainer:F2FS FILE 
SYSTEM),Changman Lee <cm224.lee@samsung.com> (maintainer:F2FS FILE 
SYSTEM),Miklos Szeredi <miklos@szeredi.hu> (maintainer:FUSE: FILESYSTEM 
IN USERSPACE),Steven Whitehouse <swhiteho@redhat.com> (supporter:GFS2 
FILE SYSTEM),Anton Altaparmakov <anton@tuxera.com> (supporter:NTFS 
FILESYSTEM),Hugh Dickins <hughd@google.com> (maintainer:TMPFS (SHMEM 
FILESYSTEM)),linux-btrfs@vger.kernel.org (open list:BTRFS FILE 
SYSTEM),linux-kernel@vger.kernel.org (open 
list),linux-fsdevel@vger.kernel.org (open list:FILESYSTEMS (VFS and 
infrastructure)),linux-ext4@vger.kernel.org (open list:EXT4 FILE 
SYSTEM),linux-f2fs-devel@lists.sourceforge.net (open list:F2FS FILE 
SYSTEM),fuse-devel@lists.sourceforge.net (open list:FUSE: FILESYSTEM IN 
USERSPACE),cluster-devel@redhat.com (open list:GFS2 FILE 
SYSTEM),linux-ntfs-dev@lists.sourceforge.net (open list:NTFS 
FILESYSTEM),linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
     Maintained,Buried alive in reporters,Supported
     BTRFS FILE SYSTEM,THE REST,FILESYSTEMS (VFS and infrastructure),EXT4 
FILE SYSTEM,F2FS FILE SYSTEM,FUSE: FILESYSTEM IN USERSPACE,GFS2 FILE 
SYSTEM,NTFS FILESYSTEM,MEMORY MANAGEMENT,TMPFS (SHMEM FILESYSTEM)

How can I parse this output automatically? or how can I generate a 
parsable output?

I need the tuples of subsystems and status:
(THE REST, Buried alive in reporters)
(TMPFS, Maintained)
(BTRFS FILE SYSTEM, Maintained)
…
(GFS2 FILE SYSTEM, Supported)

I'm not aware how to reliably assign the statuses to the subsystems.

Thank you in advance
Kind regards

Sebastian Duda

[1] https://lore.kernel.org/patchwork/patch/537252/

On 2019-07-19 10:50, Joe Perches wrote:
> On Fri, 2019-07-19 at 07:35 +0000, Duda, Sebastian wrote:
>> Hi Joe,
>> 
>> I'm conducting a large-scale patch analysis of the LKML with 1.8 
>> million
>> patch emails. I'm using the `get_maintainer.pl` script to know which
>> patch is related to which subsystem.
> 
> The MAINTAINERS file is updated frequently.
> 
> Are you also using the MAINTAINERS file used
> at the time each patch was submitted?
> 
>> I ran into two issues while using the script:
>> 
>> 1. When I use the script the trivial way
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ,
>> drivers/media/i2c/adv748x/
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Maintained,Buried alive in reporters
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST
>> 
>> the output is hard to parse because the status `Maintained` is 
>> displayed
>> only once but related to two subsystems.
>> 
>> I'd prefer a more table like representation, like this:
>> 
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),linux-media@vger.kernel.org (open
>> list:ANALOG DEVICES INC ADV748X DRIVER),ANALOG DEVICES INC ADV748X
>> DRIVER,Maintained
>>      Mauro Carvalho Chehab <mchehab@kernel.org> (maintainer:MEDIA 
>> INPUT
>> INFRASTRUCTURE (V4L/DVB)),MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),Maintained
>>      linux-kernel@vger.kernel.org (open list),THE REST,Buried alive in
>> reporters
>> 
>> 
>> 2. I want to analyze multiple patches, currently I am calling the 
>> script
>> once per patch. When calling the script with multiple files the files
>> output is merged
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ','
>> drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open
>> list),platform-driver-x86@vger.kernel.org (open list:ACPI WMI DRIVER)
>>      Maintained,Buried alive in reporters,Orphan
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST,ACPI WMI DRIVER
>> 
>> I'd like to run the script with all files but separated output, like
>> this:
>> 
>>      $ scripts/get_maintainer.pl --subsystem --status --separator ','
>> --separate-files drivers/media/i2c/adv748x/ include/uapi/linux/wmi.h
>>      Kieran Bingham <kieran.bingham@ideasonboard.com> 
>> (maintainer:ANALOG
>> DEVICES INC ADV748X DRIVER),Mauro Carvalho Chehab <mchehab@kernel.org>
>> (maintainer:MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB)),linux-media@vger.kernel.org (open list:ANALOG DEVICES INC
>> ADV748X DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Maintained,Buried alive in reporters
>>      ANALOG DEVICES INC ADV748X DRIVER,MEDIA INPUT INFRASTRUCTURE
>> (V4L/DVB),THE REST
>> 
>>      platform-driver-x86@vger.kernel.org (open list:ACPI WMI
>> DRIVER),linux-kernel@vger.kernel.org (open list)
>>      Orphan,Buried alive in reporters
>>      ACPI WMI DRIVER,THE REST
>> 
>> 
>> My Questions are:
>> 1. How can I make get_maintainer's output to be more table-like?
> 
> I suggest adding --nogit --nogit-fallback --roles --norolestats
> 
>> 2. How can I make get_maintainer.pl to separate each file's output?
> 
> Run the script with multiple invocations. once for each file
> modified by the patch.
