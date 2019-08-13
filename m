Return-Path: <SRS0=Ecng=WJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2C10C32750
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:28:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 71A4F20673
	for <linux-kernel@archiver.kernel.org>; Tue, 13 Aug 2019 06:28:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726516AbfHMG2f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 13 Aug 2019 02:28:35 -0400
Received: from muru.com ([72.249.23.125]:57038 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725836AbfHMG2e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 02:28:34 -0400
Received: from atomide.com (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id EDC38805C;
        Tue, 13 Aug 2019 06:29:01 +0000 (UTC)
Date:   Mon, 12 Aug 2019 23:28:31 -0700
From:   Tony Lindgren <tony@atomide.com>
To:     Roger Quadros <rogerq@ti.com>
Cc:     Nishka Dasgupta <nishkadg.linux@gmail.com>,
        linux-kernel@vger.kernel.org, "Kristo, Tero" <t-kristo@ti.com>
Subject: Re: [PATCH] bus: ti-sysc: Remove if-block in sysc_check_children()
Message-ID: <20190813062831.GF52127@atomide.com>
References: <20190808074042.15403-1-nishkadg.linux@gmail.com>
 <2038cdcd-1506-84c6-520d-6dda50d4f317@ti.com>
 <a1f56fcc-2207-fa32-83bc-cd219c2b893c@gmail.com>
 <b1f8756e-4b15-7f1a-8562-5b80063733de@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1f8756e-4b15-7f1a-8562-5b80063733de@ti.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Roger Quadros <rogerq@ti.com> [190813 06:26]:
> None of those functions return anything.
> Maybe you can fix sysc_check_one_child() to return void?
> I think you can retain your patch but get rid of error variable.

Makes sense to me.

Regards,

Tony
