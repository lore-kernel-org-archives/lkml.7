Return-Path: <SRS0=aq1k=VU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFB1C76188
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:31:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1AA2A227B6
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jul 2019 07:31:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388367AbfGWHbb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jul 2019 03:31:31 -0400
Received: from viti.kaiser.cx ([85.214.81.225]:52098 "EHLO viti.kaiser.cx"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731234AbfGWHbb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 03:31:31 -0400
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1hppGg-0000Pz-52; Tue, 23 Jul 2019 09:31:26 +0200
Date:   Tue, 23 Jul 2019 09:31:26 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Jessica Yu <jeyu@kernel.org>
Cc:     Yang Yingliang <yangyingliang@huawei.com>,
        linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: next-20190722, imx25: Oops when loading a module
Message-ID: <20190723073126.yzein5pwgyha75hv@viti.kaiser.cx>
References: <20190722101312.2nakxrfy7yn4a4ro@viti.kaiser.cx>
 <20190722161307.GB4297@linux-8ccs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190722161307.GB4297@linux-8ccs>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jessica,

Thus wrote Jessica Yu (jeyu@kernel.org):

> Hi Martin,

> Thank you for reporting this. Could you please try the patch I posted here:

>  https://lore.kernel.org/lkml/20190722161006.GA4297@linux-8ccs/

> And let me know if that fixes the issue for you?

yes, your patch fixes the issue on my system. Thanks.

Tested-by: Martin Kaiser <martin@kaiser.cx>
