Return-Path: <SRS0=yZjE=R4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB666C4360F
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A10BB2070D
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Mar 2019 21:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730923AbfCYV1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Mar 2019 17:27:49 -0400
Received: from smtprelay0192.hostedemail.com ([216.40.44.192]:45135 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730260AbfCYV1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Mar 2019 17:27:47 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay01.hostedemail.com (Postfix) with ESMTP id 5A620100E86C5;
        Mon, 25 Mar 2019 21:27:46 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: view20_2656d2d0a4e60
X-Filterd-Recvd-Size: 2465
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf10.hostedemail.com (Postfix) with ESMTPA;
        Mon, 25 Mar 2019 21:27:43 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vinod Koul <vkoul@kernel.org>,
        Niklas Cassel <niklas.cassel@linaro.org>,
        netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>
Subject: Bad file pattern in MAINTAINERS section 'QUALCOMM ETHQOS ETHERNET DRIVER'
Date:   Mon, 25 Mar 2019 14:27:42 -0700
Message-Id: <20190325212742.27394-1-joe@perches.com>
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

	12864	QUALCOMM ETHQOS ETHERNET DRIVER
	12865	M:	Vinod Koul <vkoul@kernel.org>
	12866	M:	Niklas Cassel <niklas.cassel@linaro.org>
	12867	L:	netdev@vger.kernel.org
	12868	S:	Maintained
	12869	F:	drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
-->	12870	F:	Documentation/devicetree/bindings/net/qcom,dwmac.txt

2: ---------------------------------------------------------------------------

The most recent commit that added or modified file pattern 'Documentation/devicetree/bindings/net/qcom,dwmac.txt':

commit 83c177aea4c37d1a2ef1e2488b25838f70cf6571
Author: Vinod Koul <vkoul@kernel.org>
Date:   Mon Jan 21 14:43:16 2019 +0530

    MAINTAINER: Add entry for Qualcomm ETHQOS ethernet driver
    
    Add myself and Niklas as maintainers for this driver
    
    Signed-off-by: Niklas Cassel <niklas.cassel@linaro.org>
    Signed-off-by: Vinod Koul <vkoul@kernel.org>
    Signed-off-by: David S. Miller <davem@davemloft.net>

 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

3: ---------------------------------------------------------------------------

No commit with file pattern 'Documentation/devicetree/bindings/net/qcom,dwmac.txt' was found
