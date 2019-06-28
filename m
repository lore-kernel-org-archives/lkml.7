Return-Path: <SRS0=E/6H=U3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 540FDC5B579
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:47:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DFA4214DA
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Jun 2019 23:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ItA1RAIJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbfF1Xq7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Jun 2019 19:46:59 -0400
Received: from merlin.infradead.org ([205.233.59.134]:49242 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbfF1Xq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 19:46:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
        Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Q6ZtwkMkJB2wj9e6jMlcIrqBM+LdxiqCoy8WdZ3lBrQ=; b=ItA1RAIJ3lULQInJzm4QIZ2Iar
        /dNb4IJwa3BMmZLRQbFflMUf/0BAhSaP+hVtYhM8FE5gupwWx8TfTtioKvSapVtGtckyx8BGP+qmG
        nytSZvNXd+/yU0Xb//JyyVWiovqG4xWQPM1tH/YqJHouBv7gCVRjQ5to+4GfpbUlZNv+d8cSdHOX7
        2NSrBw8FisJ3deLfn4DQkS8WJukpFBeViAWEGf+f1tPyUd1MO89U7hnLzuCWWnRBmClaifmId7yUV
        dfbNYcI3Ss2MJMf7EUxLMJ+G5v/wjgFweIb9c7WmWxeDq6bEjUnbQoSGACB0+CuPT4WAdhbl4g/ls
        ys8S4pJA==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=midway.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hh0Zs-0004UV-N9; Fri, 28 Jun 2019 23:46:49 +0000
Subject: Re: linux-next: Tree for Jun 28 (power/reset/reboot-mode)
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Nandor Han <nandor.han@vaisala.com>,
        Andy Yan <andy.yan@rock-chips.com>,
        Sebastian Reichel <sre@kernel.org>,
        Linux PM list <linux-pm@vger.kernel.org>
References: <20190628203840.1f74e739@canb.auug.org.au>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <bb7b5d1a-97b5-7f74-4075-eeb290fd9508@infradead.org>
Date:   Fri, 28 Jun 2019 16:46:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190628203840.1f74e739@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/19 3:38 AM, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20190627:
> 

on x86_64:

when CONFIG_OF is not set/enabled, but
CONFIG_NVMEM_REBOOT_MODE=m selects REBOOT_MODE:

  CC [M]  drivers/power/reset/reboot-mode.o
../drivers/power/reset/reboot-mode.c: In function ‘reboot_mode_register’:
../drivers/power/reset/reboot-mode.c:72:2: error: implicit declaration of function ‘for_each_property_of_node’ [-Werror=implicit-function-declaration]
  for_each_property_of_node(np, prop) {
  ^
../drivers/power/reset/reboot-mode.c:72:38: error: expected ‘;’ before ‘{’ token
  for_each_property_of_node(np, prop) {
                                      ^
../drivers/power/reset/reboot-mode.c:109:1: warning: label ‘error’ defined but not used [-Wunused-label]
 error:
 ^
../drivers/power/reset/reboot-mode.c:67:9: warning: unused variable ‘len’ [-Wunused-variable]
  size_t len = strlen(PREFIX);
         ^
../drivers/power/reset/reboot-mode.c: At top level:
../drivers/power/reset/reboot-mode.c:42:12: warning: ‘reboot_mode_notify’ defined but not used [-Wunused-function]
 static int reboot_mode_notify(struct notifier_block *this,
            ^


-- 
~Randy
