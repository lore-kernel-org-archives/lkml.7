Return-Path: <SRS0=6YJq=VW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE5A7C76190
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85F0522BE8
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jul 2019 17:50:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="2A7zoUHo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbfGYRuS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jul 2019 13:50:18 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37712 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726591AbfGYRuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 13:50:17 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PHneBn053659;
        Thu, 25 Jul 2019 17:50:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to :
 subject : message-id : mime-version : content-type; s=corp-2018-07-02;
 bh=T/6UXjTIk4O6K3Oj5xQH/Mu3o8xx8bGvbsb/pf1PMMc=;
 b=2A7zoUHoRPgAh3r0/WGbCARKwST+kryKnKc+P3fESgFE0rH9dONDOBUUp7u3ZRqfjMYO
 nPluHEhkjL7ZyeVgWizFphXdKdTak1Bel2iUGJXf6T2xYsKVGyVKGzyWQOpOmtlrWwW3
 daoI+fMbtcntIVy5vUUMVibm7yZ4ahOXDIHwc5yCBBdkt5XX/l6dsXAsxKNQVsMYjF2X
 xPuJzLkMwVbOD+TFk/opsQCs2HoGUb7uL9qox9OjwZTFmFSvAFRmiP5zXA6ZUsUt/ITY
 lk8q0AEEiMIQXXss/G2KppwjXI13ZJTErDnNkzUan1ClyNXeR305j5A6pUVAjHlIrcre SQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2tx61c5n98-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:50:15 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6PHgdxV074027;
        Thu, 25 Jul 2019 17:50:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3030.oracle.com with ESMTP id 2tx60xy602-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 25 Jul 2019 17:50:14 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6PHoEf5007397;
        Thu, 25 Jul 2019 17:50:14 GMT
Received: from char.us.oracle.com (/10.152.32.25)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 25 Jul 2019 10:50:14 -0700
Received: by char.us.oracle.com (Postfix, from userid 1000)
        id 99CF06A0133; Thu, 25 Jul 2019 13:52:07 -0400 (EDT)
Date:   Thu, 25 Jul 2019 13:52:07 -0400
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (ibft) for-linus-5.3
Message-ID: <20190725175207.GC11606@char.us.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.1 (2017-09-22)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907250209
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9329 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907250210
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hey Linus,

Please git pull the following branch which is a tiny bit late (patch
was posted furing merge window and I wanted to wait until rc1):


git://git.kernel.org/pub/scm/linux/kernel/git/konrad/ibft.git for-linus-5.3

which has one tiny fix to enable iSCSI IBFT to be compiled under ARM.

Thank you.

 drivers/firmware/Kconfig      | 5 +++--
 drivers/firmware/iscsi_ibft.c | 4 ++++
 2 files changed, 7 insertions(+), 2 deletions(-)

Thomas Tai (1):
      iscsi_ibft: make ISCSI_IBFT dependson ACPI instead of ISCSI_IBFT_FIND

