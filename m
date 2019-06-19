Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7FC4C31E49
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC9E820823
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 04:40:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="n86cBl3A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730250AbfFSEkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 00:40:51 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48490 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725854AbfFSEku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 00:40:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J4dA2U136343;
        Wed, 19 Jun 2019 04:40:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id; s=corp-2018-07-02;
 bh=xCG15FH/MMpgMm7ED9PXskNDW9T4VwJa/+lUjFrH2e4=;
 b=n86cBl3APDwvWmt/owoAqZB95BWTcSWBukuk6/lt+jVdQAonOkGjMKs5OTUd4AgBFdZj
 Vv2dKff8UxD4n5bbdNoYJ+ieaclnYu5fcbtmIJwtqCQP+abSnw+m4EYojnUkd19igX4Y
 PTVRflzf49o8XNJ+9x/Km8prEDUGGrkwb7z8iPaFF9BJaX87rjD77BGpKu4ibp13OjfP
 w5hVHm7Paqilwgr8y2/YmH3Jcw/fX7D9fa89qB4otlBTRrHfuRviUioJIl7XtzwOhB8h
 vcUYoZzxNLAKUUcLLoUxH/r+aSxSXFFt5fTqbP+qEAxeTis6ZswII3x9u32hDDc5kcpQ hA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2t780990a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 04:40:43 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J4eW5K101604;
        Wed, 19 Jun 2019 04:40:42 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2t77ynkw0q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 04:40:42 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5J4eZBY010913;
        Wed, 19 Jun 2019 04:40:35 GMT
Received: from localhost.localdomain (/10.159.132.89)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 18 Jun 2019 21:40:34 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [GIT PULL] ARM: TI SOC updates for v5.3
Date:   Tue, 18 Jun 2019 21:40:18 -0700
Message-Id: <1560919218-3847-1-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=802
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190037
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=852 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190037
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit cd6c84d8f0cdc911df435bb075ba22ce3c605b07:

  Linux 5.2-rc2 (2019-05-26 16:49:19 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/drivers_soc_for_5.3

for you to fetch changes up to 4c960505df44b94001178575a505dd8315086edc:

  firmware: ti_sci: Fix gcc unused-but-set-variable warning (2019-06-18 21:32:25 -0700)

----------------------------------------------------------------
SOC: TI SCI updates for v5.3

- Couple of fixes to handle resource ranges and
  requesting response always from firmware;
- Add processor control
- Add support APIs for DMA
- Fix the SPDX license plate
- Unused varible warning fix

----------------------------------------------------------------
Andrew F. Davis (1):
      firmware: ti_sci: Always request response from firmware

Nishad Kamdar (1):
      firmware: ti_sci: Use the correct style for SPDX License Identifier

Peter Ujfalusi (2):
      firmware: ti_sci: Add resource management APIs for ringacc, psi-l and udma
      firmware: ti_sci: Parse all resource ranges even if some is not available

Suman Anna (1):
      firmware: ti_sci: Add support for processor control

YueHaibing (1):
      firmware: ti_sci: Fix gcc unused-but-set-variable warning

 drivers/firmware/ti_sci.c              | 1143 +++++++++++++++++++++++++++-----
 drivers/firmware/ti_sci.h              |  812 ++++++++++++++++++++++-
 include/linux/soc/ti/ti_sci_protocol.h |  246 +++++++
 3 files changed, 2051 insertions(+), 150 deletions(-)
