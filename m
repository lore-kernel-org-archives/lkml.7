Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B83EC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:30:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 286762075E
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 23:30:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbfCYXao (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 19:30:44 -0400
Received: from smtprelay0077.hostedemail.com ([216.40.44.77]:39155 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726276AbfCYXao (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 19:30:44 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id B2C948368EFA;
        Mon, 25 Mar 2019 23:30:42 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: pull74_5d667eb128215
X-Filterd-Recvd-Size: 2810
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf19.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 23:30:41 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     James Wang <james.qian.wang@arm.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Mali DP Maintainers <malidp@foss.arm.com>
Subject: Bad file pattern in MAINTAINERS section 'ARM KOMEDA DRM-KMS DRIVER'
Date:   Mon, 25 Mar 2019 16:30:40 -0700
Message-Id: <20190325233040.30983-1-joe@perches.com>
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

	1162	ARM KOMEDA DRM-KMS DRIVER
	1163	M:	James (Qian) Wang <james.qian.wang@arm.com>
	1164	M:	Liviu Dudau <liviu.dudau@arm.com>
	1165	L:	Mali DP Maintainers <malidp@foss.arm.com>
	1166	S:	Supported
	1167	T:	git git://linux-arm.org/linux-ld.git for-upstream/mali-dp
	1168	F:	drivers/gpu/drm/arm/display/include/
	1169	F:	drivers/gpu/drm/arm/display/komeda/
-->	1170	F:	Documentation/devicetree/bindings/display/arm/arm,komeda.txt
	1171	F:	Documentation/gpu/komeda-kms.rst

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/display/arm/arm,komeda.txt':

commit ab6911b73493fac9cdcc3b2c77ddca6b1016e057
Author: james qian wang (Arm Technology China) <james.qian.wang@arm.com>
Date:   Thu Jan 3 11:42:05 2019 +0000

    MAINTAINERS: Add maintainer for Arm komeda driver
    
    v4: Added git tree [Daniel Vetter]
    v2: Adjusted the position of KOMEDA by alphabetical order
    
    Signed-off-by: James Qian Wang (Arm Technology China) <james.qian.wang@arm.com>
    Acked-by: Liviu Dudau <liviu.dudau@arm.com>
    [Updated entry to show that Mali Developers is a mailing list and
     to add myself as maintainer]
    Signed-off-by: Liviu Dudau <liviu.dudau@arm.com>

 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'Documentation/devicetree/bindings/display/arm/arm,komeda.txt' was found
