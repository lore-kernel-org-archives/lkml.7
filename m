Return-Path: <SRS0=wETr=XU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08724C432C1
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:56:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DB611205F4
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Sep 2019 11:56:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391319AbfIYL4W (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Sep 2019 07:56:22 -0400
Received: from esa1.mentor.iphmx.com ([68.232.129.153]:47781 "EHLO
        esa1.mentor.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727569AbfIYL4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Sep 2019 07:56:21 -0400
IronPort-SDR: 6hoGZS8PRye7BfsobyWFuMbYsucrrTBbGy9lOePrDb/QDfmcuk57HuMxFnP4yXzSD5V6KD63SX
 JFYAgW14wY2gW48SOChMnjB9zo4fZbUiqnmVzokYAa/5RDMd9WsQ9Oco3zKVx979qSQEOC+09h
 4sIALGhOw7dTY3ZTNyacvbTo4wbJqp7pug6bNBEBjGZf3fqsEDM82ZtbKqhfjM9CPLsANl7rIz
 nQZuKMMlUIbhKxo2dMzm5qp7NMSiXmC3oeH35qVcr5I/ZW78+U7LR6Enx5huXjzUJw7CUs0jnX
 GMo=
X-IronPort-AV: E=Sophos;i="5.64,547,1559548800"; 
   d="scan'208";a="43482244"
Received: from orw-gwy-01-in.mentorg.com ([192.94.38.165])
  by esa1.mentor.iphmx.com with ESMTP; 25 Sep 2019 03:56:21 -0800
IronPort-SDR: 7x9jJtQ6P4/K7DzPs6r8aR9HOa1y874QI1tUdtJDMYoAUN1yoek22pN20GJwHTSMQ6fyCVeJWv
 phYBIXqbxm7NLrQ37sWFfadOMfB9d2MKSZUwIsMsyPWmiz8oiIpXw5AAzH4WszpBW+zJxiFyEu
 tJ5dfkLZdEtlAlRA0us/I0Ebqp5w5CD1IfVui/n/01CNL+B2PeRaDwqOThNIOVuFjFLFZqRBAP
 aaVInsaaByqtuCv+mMu7i/fylLmEKAS3BuN34PFJWsPVUOhU6v80qzu0D44BVagMPIBV24r8Cd
 TyI=
From:   Balasubramani Vivekanandan <balasubramani_vivekanandan@mentor.com>
To:     <fweisbec@gmail.com>, <tglx@linutronix.de>, <mingo@kernel.org>
CC:     <balasubramani_vivekanandan@mentor.com>, <erosca@de.adit-jv.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 1/1] tick: broadcast-hrtimer: Fix a race in bc_set_next
Date:   Wed, 25 Sep 2019 13:55:40 +0200
Message-ID: <20190925115541.1170-1-balasubramani_vivekanandan@mentor.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <alpine.DEB.2.21.1909232041080.1934@nanos.tec.linutronix.de>
References: <alpine.DEB.2.21.1909232041080.1934@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [137.202.0.90]
X-ClientProxiedBy: SVR-IES-MBX-07.mgc.mentorg.com (139.181.222.7) To
 svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Find a completely untested patch below

Thanks for the patch. I tested your patch and it is working fine. I do
not notice the rcu stall warnings anymore. I have just updated the
formatting of brackets. Please check and apply



