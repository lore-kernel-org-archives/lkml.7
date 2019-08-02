Return-Path: <SRS0=qq9d=V6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10D88C433FF
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:40:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E690320657
	for <linux-kernel@archiver.kernel.org>; Fri,  2 Aug 2019 06:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388806AbfHBGke (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 2 Aug 2019 02:40:34 -0400
Received: from ns.gsystem.sk ([62.176.172.50]:54088 "EHLO gsystem.sk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726539AbfHBGke (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Aug 2019 02:40:34 -0400
X-Greylist: delayed 1732 seconds by postgrey-1.27 at vger.kernel.org; Fri, 02 Aug 2019 02:40:33 EDT
Received: from [192.168.1.3]
        by gsystem.sk with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <linux@zary.sk>)
        id 1htQmv-0001ug-9a; Fri, 02 Aug 2019 08:11:37 +0200
From:   Ondrej Zary <linux@zary.sk>
To:     Mark Balantzyan <mbalant3@gmail.com>
Subject: Re: [PATCH v4] watchdog: alim1535: Rewriting of alim1535 driver to use watchdog subsystem
Date:   Fri, 2 Aug 2019 08:11:34 +0200
User-Agent: KMail/1.9.10
Cc:     linux@roeck-us.net, wim@linux-watchdog.org,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190802041218.66127-1-mbalant3@gmail.com>
In-Reply-To: <20190802041218.66127-1-mbalant3@gmail.com>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <201908020811.35112.linux@zary.sk>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 02 August 2019, Mark Balantzyan wrote:
> This patch rewrites the alim1535_wdt driver to use the watchdog subsystem.
> By virtue of this, it also fixes a (theoretical) race condition between the
> formerly arranged ali_timeout_bits and ali_settimer() interoperation.

Please don't rewrite drivers you can't test.

-- 
Ondrej Zary
