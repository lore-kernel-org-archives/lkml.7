Return-Path: <SRS0=D3m8=SL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95A22C282CE
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:04:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 718222084F
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Apr 2019 14:04:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfDIOED (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Apr 2019 10:04:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34880 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726438AbfDIOEC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Apr 2019 10:04:02 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id E1157307EA8D;
        Tue,  9 Apr 2019 14:04:01 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D36391001E69;
        Tue,  9 Apr 2019 14:04:00 +0000 (UTC)
Date:   Tue, 9 Apr 2019 16:03:58 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.33.2
Message-ID: <20190409140358.b3hssvd5bgqmbdtb@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: NeoMutt/20180716-1108-40af05
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.44]); Tue, 09 Apr 2019 14:04:01 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The util-linux stable release v2.33.2 is available at

  http://www.kernel.org/pub/linux/utils/util-linux/v2.33/

Feedback and bug reports, as always, are welcomed.

  Karel


util-linux 2.33.2 Release Notes
===============================

agetty:
   - Fix input of non-ASCII characters in get_logname()  [Stanislav Brabec]
   - Switch to 8-bit processing in get_logname() for UTF-8 terminals  [Stanislav Brabec]
bash-completion:
   - umount support relative path and ~ as home shorthands  [Sami Kerola]
blkid:
   - (man) cleanup return code section  [Karel Zak]
build-sys:
   - fix crypt() detection without -lcrypt  [Johannes Nixdorf]
column:
   - Address fill-order confusion in documentation  [dana]
docs:
   - update AUTHORS file  [Karel Zak]
fstrim:
   - Remove commnet about vfat not supporting fstrim  [Marcos Paulo de Souza]
include:
   - add no return function attribute  [Sami Kerola]
include/path.h:
   - remove duplicate header inclusion  [Sami Kerola]
last:
   - do not use non-standard __UT_NAMESIZE  [Patrick Steinhardt]
   - fix wtmp user name buffer overflow [asan]  [Sami Kerola]
libfdisk:
   - (dos) Use strtoul to parse the label-id  [Juerg Haefliger]
   - (gpt) add HiFive Unleashed bootloader partition UUIDs  [Icenowy Zheng]
   - sanity check, to prevent overlapping partitions from being partly reported as free  [Fabian.Kirsch@dlr.de]
libmount:
   - Recognize more fuse filesystems as pseudofs and netfs  [Stanislav Brabec]
   - don't use sscanf() for fstab parsing  [Karel Zak]
   - don't use sscanf() for mountinfo parsing  [Karel Zak]
   - don't use sscanf() for swaps parsing  [Karel Zak]
logger:
   - (man) make more obvious that --server/socket is required  [Karel Zak]
losetup:
   - use offset in warn_size() calculation  [Karel Zak]
lscpu:
   - document --hex output regression (since v2.30)  [Karel Zak]
mount:
   - Do not call mnt_pretty_path() on net file systems.  [Stanislav Brabec]
   - mount.8 clarify (no)suid behavior on file capabilities  [Peter Wu]
po:
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
readprofile:
   - check input file is not empty [asan]  [Sami Kerola]
setarch:
   - don't return address of automatic variable  [Andreas Schwab]
sfdisk:
   - fix logical partition resize when start specified  [Karel Zak]
su:
   - be sensitive to another SIGCHLD ssi_codes  [Karel Zak]
   - change error message  [Karel Zak]
tests:
   - add /mnt/test/foo^Mbar to mountinfo tests  [Karel Zak]
wall:
   - remove unnecessary warning  [Karel Zak]
whereis:
   - search in /(s)bin before /usr/lib  [Karel Zak]
