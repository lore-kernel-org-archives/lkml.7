Return-Path: <SRS0=EKka=XV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBCBAC4360C
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A1F0F222C3
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Sep 2019 16:59:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727670AbfIZQ7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Sep 2019 12:59:06 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:25104 "EHLO
        cmccmta3.chinamobile.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727512AbfIZQ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Sep 2019 12:59:01 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.19]) by rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5d8cec1ae9e-2eb7a; Fri, 27 Sep 2019 00:49:33 +0800 (CST)
X-RM-TRANSID: 2eeb5d8cec1ae9e-2eb7a
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from localhost (unknown[223.105.0.241])
        by rmsmtp-syy-appsvr10-12010 (RichMail) with SMTP id 2eea5d8cec0ffd4-705b5;
        Fri, 27 Sep 2019 00:49:20 +0800 (CST)
X-RM-TRANSID: 2eea5d8cec0ffd4-705b5
From:   Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
To:     Shuah Khan <shuah@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        "David S. Miller" <davem@davemloft.net>
Cc:     Julian Anastasov <ja@ssi.bg>, linux-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org,
        Haishuang Yan <yanhaishuang@cmss.chinamobile.com>
Subject: [PATCH 0/3] selftests: netfilter: introduce test cases for ipvs
Date:   Fri, 27 Sep 2019 00:48:49 +0800
Message-Id: <1569516532-708-1-git-send-email-yanhaishuang@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series patch include test cases for ipvs.

The test topology is who as below:
+--------------------------------------------------------------+
|                      |                                       |
|         ns0          |         ns1                           |
|      -----------     |     -----------    -----------        |
|      | veth01  | --------- | veth10  |    | veth12  |        |
|      -----------    peer   -----------    -----------        |
|           |          |                        |              |
|      -----------     |                        |              |
|      |  br0    |     |-----------------  peer |--------------|
|      -----------     |                        |              |
|           |          |                        |              |
|      ----------     peer   ----------      -----------       |
|      |  veth02 | --------- |  veth20 |     | veth12  |       |
|      ----------      |     ----------      -----------       |
|                      |         ns2                           |
|                      |                                       |
+--------------------------------------------------------------+

Test results:
# selftests: netfilter: ipvs.sh
# Testing DR mode...
# Testing NAT mode...
# Testing Tunnel mode...
# ipvs.sh: PASS
ok 6 selftests: netfilter: ipvs.sh

Haishuang Yan (3):
  selftests: netfilter: add ipvs test script
  selftests: netfilter: add ipvs nat test case
  selftests: netfilter: add ipvs tunnel test case

 tools/testing/selftests/netfilter/Makefile |   2 +-
 tools/testing/selftests/netfilter/ipvs.sh  | 230 +++++++++++++++++++++++++++++
 2 files changed, 231 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/netfilter/ipvs.sh

-- 
1.8.3.1



