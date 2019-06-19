Return-Path: <SRS0=wAGj=US=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C83BEC31E5E
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:33:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACFC121479
	for <linux-kernel@archiver.kernel.org>; Wed, 19 Jun 2019 07:33:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731199AbfFSHdV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Jun 2019 03:33:21 -0400
Received: from mail.windriver.com ([147.11.1.11]:63418 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbfFSHdU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 03:33:20 -0400
Received: from ALA-HCA.corp.ad.wrs.com ([147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id x5J7WxhF016777
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Jun 2019 00:32:59 -0700 (PDT)
Received: from pek-lpggp2 (128.224.153.75) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.439.0; Wed, 19 Jun 2019
 00:32:58 -0700
Received: by pek-lpggp2 (Postfix, from userid 20544)    id B7372720728; Wed, 19
 Jun 2019 15:15:20 +0800 (CST)
From:   Jiping Ma <jiping.ma2@windriver.com>
To:     <jbaron@akamai.com>
CC:     <linux-edac@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mchehab@kernel.org>, <bp@alien8.de>, <jiping.ma2@windriver.com>
Subject: Review request for edac: ie31200: Add Intel Corporation 3rd Gen Core processor
Date:   Wed, 19 Jun 2019 15:15:17 +0800
Message-ID: <1560928518-243100-1-git-send-email-jiping.ma2@windriver.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Jason Baron

Could you help to check if we can support Intel Corporation 3rd Gen Core processor in driver ie31200?
It is tested by our customer. Test result is accepted by the customer.


Summary: EDAC, ie31200: Add Intel Corporation 3rd Gen Core processor


commit 9a5001c8840928c3b51bc330a078524dff4d9be5 (HEAD -> master)
Author: Jiping Ma <jiping.ma2@windriver.com>
Date:   Mon Jun 17 13:36:20 2019 +0800

EDAC, ie31200: Add Intel Corporation 3rd Gen Core processor
    
3rd Gen Core seems to work just like Skylake.
  
Signed-off-by: Jiping Ma <jiping.ma2@windriver.com>


Thanks,
Jiping
