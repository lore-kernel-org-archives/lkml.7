Return-Path: <SRS0=19dG=ZH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29AF9C432C3
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:07:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B4F420728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Nov 2019 06:07:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbfKOGHP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Nov 2019 01:07:15 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:49926 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727208AbfKOGHN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Nov 2019 01:07:13 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.08837032|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.0377916-0.00102263-0.961186;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03301;MF=fuyao@allwinnertech.com;NM=1;PH=DS;RN=4;RT=4;SR=0;TI=SMTPD_---.G-yTRwf_1573798030;
Received: from localhost(mailfrom:fuyao@allwinnertech.com fp:SMTPD_---.G-yTRwf_1573798030)
          by smtp.aliyun-inc.com(10.194.99.21);
          Fri, 15 Nov 2019 14:07:10 +0800
Date:   Fri, 15 Nov 2019 14:06:04 +0800
From:   fuyao <fuyao@allwinnertech.com>
To:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?5p2O6Z2ZcHN3?= <lijingpsw@allwinnertech.com>
Subject: [power supply]:missing definition without config
Message-ID: <20191115060604.GE17312@AExdroid03>
Mail-Followup-To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        =?utf-8?B?6bqm6ZSu5qif?= <maijianzhang@allwinnertech.com>,
        =?utf-8?B?5p2O6Z2ZcHN3?= <lijingpsw@allwinnertech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Organization: fuyao_love_xxt.Allwinnertech.Technology
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-pm:
hi, walk around the power_supply.h file. 
call power_supply_get_by_name without the CONFIG_POWER_SUPPLY, cause
error.
if we should use:

#ifdef CONFIG_POWER_SUPPLY
extern extern struct power_supply *power_supply_get_by_name(const char *name);
#else
static inline struct power_supply *
power_supply_get_by_name(const char *name)
{return NULL;}
#endif

