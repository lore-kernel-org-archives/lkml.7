Return-Path: <SRS0=hO5d=UX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E776AC43613
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:35:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3332205F4
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Jun 2019 06:35:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727134AbfFXGfs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Jun 2019 02:35:48 -0400
Received: from verein.lst.de ([213.95.11.211]:52771 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726312AbfFXGfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jun 2019 02:35:48 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 3F22968AFE; Mon, 24 Jun 2019 08:35:16 +0200 (CEST)
Date:   Mon, 24 Jun 2019 08:35:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Fredrik Noring <noring@nocrew.org>
Cc:     Guenter Roeck <linux@roeck-us.net>, laurentiu.tudor@nxp.com,
        hch@lst.de, stern@rowland.harvard.edu, gregkh@linuxfoundation.org,
        linux-usb@vger.kernel.org, marex@denx.de, leoyang.li@nxp.com,
        linux-kernel@vger.kernel.org, robin.murphy@arm.com,
        JuergenUrban@gmx.de
Subject: Re: [PATCH v7 3/5] usb: host: ohci-sm501: init genalloc for local
 memory
Message-ID: <20190624063515.GA3296@lst.de>
References: <20190529102843.13174-4-laurentiu.tudor@nxp.com> <20190605214622.GA22254@roeck-us.net> <20190611133223.GA30054@roeck-us.net> <20190611172654.GA2602@sx9> <20190611190343.GA18459@roeck-us.net> <20190613134033.GA2489@sx9> <bdfd2178-9e3c-dc15-6aa1-ec1f1fbcb191@roeck-us.net> <20190613153414.GA909@sx9> <3f2164cd-7655-b7cc-ec57-d8751886728c@roeck-us.net> <20190614142816.GA2574@sx9>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190614142816.GA2574@sx9>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Can you send me the patch formally so that I can queue it up for the
dma-mapping tree?
