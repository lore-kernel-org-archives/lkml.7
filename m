Return-Path: <SRS0=sYEh=YW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041DCCA9EAE
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D02E920830
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Oct 2019 18:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="iGMi7HG2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731095AbfJ2SOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Oct 2019 14:14:32 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49356 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731022AbfJ2SOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Oct 2019 14:14:32 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI5T80155035;
        Tue, 29 Oct 2019 18:14:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2019-08-05;
 bh=qaQdjobmQtaH6OaMW3nXXlGU1il8zvLtLFMQ9b8Lhjc=;
 b=iGMi7HG2OLI+ccbYCT0uY2MV3I3m5uQEXXRSgyMNboYyj42W53jgFjOKQk8uVtpmj+5w
 hOEBJqRHcwh6c6FSpToeyqNduoh4I+Sg5BzCzHUUwAeY21C/jVT+aIYJozC1AbW7kLdF
 q17VYjpljfIEQyZ5XcT8z4V2QG5xsuTUa8qaqQXMx7qdONW/DKLq36637WzTDbKfcYaO
 z6ozkEZ2eSCVZh4S+27pa9flJYgYWtOsoxkLA/38cwnec1N6RhB7pCs51j3eycSDEliM
 71H2WlnBoJsN8FiqYchI3jmv0N4lllFV2qhWwt3WrtXZgUeeTCRXgATetkiQgeQcBeE8 rw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2vve3qb19j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:14:24 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9TI8Ro6052354;
        Tue, 29 Oct 2019 18:14:23 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2vxj8gpw76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Oct 2019 18:14:23 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9TIEMB0005800;
        Tue, 29 Oct 2019 18:14:22 GMT
Received: from localhost.localdomain (/10.159.132.196)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 29 Oct 2019 11:14:22 -0700
From:   Santosh Shilimkar <santosh.shilimkar@oracle.com>
To:     arm@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     khilman@kernel.org, arnd@arndb.de, olof@lixom.net,
        linux-kernel@vger.kernel.org, santosh.shilimkar@oracle.com
Subject: [RESEND][GIT PULL 2/2] ARM: Keystone platform DTS updates for v5.5
Date:   Tue, 29 Oct 2019 11:14:16 -0700
Message-Id: <1572372856-20598-2-git-send-email-santosh.shilimkar@oracle.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1572372856-20598-1-git-send-email-santosh.shilimkar@oracle.com>
References: <1572372856-20598-1-git-send-email-santosh.shilimkar@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=612
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910290160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9425 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=712 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910290160
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 54ecb8f7028c5eb3d740bb82b0f1d90f2df63c5c:

  Linux 5.4-rc1 (2019-09-30 10:35:40 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git for_5.5/keystone-dts

for you to fetch changes up to cfc0e76bbbde6875e026c18ea72f181e5d00d93f:

  ARM: configs: keystone: enable cpts (2019-10-07 10:59:10 -0700)

----------------------------------------------------------------
Grygorii Strashko (6):
      ARM: dts: keystone-clocks: add input fixed clocks
      ARM: dts: k2e-clocks: add input ext. fixed clocks tsipclka/b
      ARM: dts: k2e-netcp: add cpts refclk_mux node
      ARM: dts: k2hk-netcp: add cpts refclk_mux node
      ARM: dts: k2l-netcp: add cpts refclk_mux node
      ARM: configs: keystone: enable cpts

 arch/arm/boot/dts/keystone-clocks.dtsi     | 27 +++++++++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-clocks.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/keystone-k2e-netcp.dtsi  | 21 +++++++++++++++++++--
 arch/arm/boot/dts/keystone-k2hk-netcp.dtsi | 20 ++++++++++++++++++--
 arch/arm/boot/dts/keystone-k2l-netcp.dtsi  | 20 ++++++++++++++++++--
 arch/arm/configs/keystone_defconfig        |  1 +
 6 files changed, 103 insertions(+), 6 deletions(-)
