Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 342D2C43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E38420848
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730519AbfCYVYv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:24:51 -0400
Received: from smtprelay0169.hostedemail.com ([216.40.44.169]:41429 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729569AbfCYVYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:24:51 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 8C424182CF66A;
        Mon, 25 Mar 2019 21:24:49 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: laugh28_cd10bac20c50
X-Filterd-Recvd-Size: 2956
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:24:47 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Brendan Higgins <brendanhiggins@google.com>,
        openbmc@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>
Subject: Bad file pattern in MAINTAINERS section 'ARM/NUVOTON NPCM ARCHITECTURE'
Date:   Mon, 25 Mar 2019 14:24:46 -0700
Message-Id: <20190325212446.25795-1-joe@perches.com>
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

	1893	ARM/NUVOTON NPCM ARCHITECTURE
	1894	M:	Avi Fishman <avifishman70@gmail.com>
	1895	M:	Tomer Maimon <tmaimon77@gmail.com>
	1896	R:	Patrick Venture <venture@google.com>
	1897	R:	Nancy Yuen <yuenn@google.com>
	1898	R:	Brendan Higgins <brendanhiggins@google.com>
	1899	L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
	1900	S:	Supported
	1901	F:	arch/arm/mach-npcm/
	1902	F:	arch/arm/boot/dts/nuvoton-npcm*
-->	1903	F:	include/dt-bindings/clock/nuvoton,npcm7xx-clks.h
	1904	F:	drivers/*/*npcm*
	1905	F:	Documentation/devicetree/bindings/*/*npcm*
	1906	F:	Documentation/devicetree/bindings/*/*/*npcm*

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'include/dt-bindings/clock/nuvoton,npcm7xx-clks.h':

commit 6a498e06ba22872d3a27cc0dae77b9314b1de48b
Author: Brendan Higgins <brendanhiggins@google.com>
Date:   Thu Aug 17 09:44:32 2017 -0700

    MAINTAINERS: Add entry for the Nuvoton NPCM architecture
    
    Add maintainers and reviewers for the Nuvoton NPCM architecture.
    
    Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
    Reviewed-by: Tomer Maimon <tmaimon77@gmail.com>
    Reviewed-by: Avi Fishman <avifishman70@gmail.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

 MAINTAINERS | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'include/dt-bindings/clock/nuvoton,npcm7xx-clks.h' was found
