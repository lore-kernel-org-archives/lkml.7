Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B1CCC4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 257962084D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:28:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730815AbfCYV12 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:28 -0400
Received: from smtprelay0019.hostedemail.com ([216.40.44.19]:58470 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730660AbfCYV1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:22 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay02.hostedemail.com (Postfix) with ESMTP id A2C6F127B;
        Mon, 25 Mar 2019 21:27:20 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: test88_22ac0b48a9e2c
X-Filterd-Recvd-Size: 3657
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf20.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:18 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Subject: Bad file pattern in MAINTAINERS section 'MIPS/LOONGSON2 ARCHITECTURE'
Date:   Mon, 25 Mar 2019 14:27:16 -0700
Message-Id: <20190325212717.27044-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
References: <7cd8d12f59bcacd18a78f599b46dac555f7f16c0.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A file pattern line in this section of the MAINTAINERS file in linux-next
does not have a match in the linux source files.

This could occur because a matching filename was never added, was deleted
or renamed in some other commit.

The commits that added and if found renamed or removed the file pattern
are shown below.

Please fix this defect appropriately.

1: ---------------------------------------------------------------------------

linux-next MAINTAINERS section:

	10355	MIPS/LOONGSON2 ARCHITECTURE
	10356	M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
	10357	L:	linux-mips@vger.kernel.org
	10358	S:	Maintained
	10359	F:	arch/mips/loongson64/fuloong-2e/
	10360	F:	arch/mips/loongson64/lemote-2f/
	10361	F:	arch/mips/include/asm/mach-loongson64/
	10362	F:	drivers/*/*loongson2*
-->	10363	F:	drivers/*/*/*loongson2*

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'drivers/*/*/*loongson2*':

commit ffe1f9356fbe55df7dd7f7f6b050ee8b7136611f
Author: Huacai Chen <chenhc@lemote.com>
Date:   Thu Dec 7 14:31:08 2017 +0800

    MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
    
    Add Jiaxun Yang as the MIPS/Loongson-2 maintainer and add Huacai Chen
    as the MIPS/Loongson-3 maintainer.
    
    [ralf@linux-mips.org: Don't put all of drivers/platform/mips/ into these
    two entries but rather only the files required even though at this time
    the Loongson platforms are the only users of drivers/platform/mips/.]
    
    Signed-off-by: Huacai Chen <chenhc@lemote.com>
    Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
    Cc: Linus Torvalds <torvalds@linux-foundation.org>
    Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
    Cc: Stephen Rothwell <sfr@canb.auug.org.au>
    Cc: James Hogan <james.hogan@mips.com>
    Cc: Rui Wang <wangr@lemote.com>
    Cc: Binbin Zhou <zhoubb@lemote.com>
    Cc: Ce Sun <sunc@lemote.com>
    Cc: Yao Wang <wangyao@lemote.com>
    Cc: Liangliang Huang <huangll@lemote.com>
    Cc: Fuxin Zhang <zhangfx@lemote.com>
    Cc: Zhangjin Wu <wuzhangjin@gmail.com>
    Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
    Cc: r@hev.cc
    Cc: zhoubb.aaron@gmail.com
    Cc: huanglllzu@163.com
    Cc: 513434146@qq.com
    Cc: 1393699660@qq.com
    Cc: linux-mips@linux-mips.org
    Cc: linux-kernel@vger.kernel.org
    Cc: Huacai Chen <chenhc@lemote.com>
    Patchwork: https://patchwork.linux-mips.org/patch/17888/
    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
    Signed-off-by: James Hogan <jhogan@kernel.org>

 MAINTAINERS | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'drivers/*/*/*loongson2*' was found
