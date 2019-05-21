Return-Path: <SRS0=9PYC=TV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 820D4C04AAF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 616B32182B
	for <linux-kernel@archiver.kernel.org>; Tue, 21 May 2019 19:37:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727484AbfEUThj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 May 2019 15:37:39 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:54416 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727046AbfEUThj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 May 2019 15:37:39 -0400
Received: from [192.168.1.91] (unknown [77.207.133.132])
        (Authenticated sender: marc.w.gonzalez)
        by smtp4-g21.free.fr (Postfix) with ESMTPSA id 0795919F58C;
        Tue, 21 May 2019 21:37:30 +0200 (CEST)
Subject: Re: [PATCH] dt: bindings: mtd: replace references to nand.txt with
 nand-controller.yaml
To:     Kamal Dasu <kdasu.kdev@gmail.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
References: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <20f9a1cf-7779-434b-c589-d0ab9c4b481f@free.fr>
Date:   Tue, 21 May 2019 21:37:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1558466890-45471-1-git-send-email-kdasu.kdev@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/05/2019 21:27, Kamal Dasu wrote:

> nand-controller.yaml replaced nand.txt however the references to it were
> not updated. This change updates these references wherever it appears in
> bindings documentation.
> 
> Fixes: 212e49693592 ("dt-bindings: mtd: Add YAML schemas for the generic NAND options")
> 
> Signed-off-by: Kamal Dasu <kdasu.kdev@gmail.com>

You should coordinate with Mauro:

https://patchwork.kernel.org/patch/10951631/

Regards.
