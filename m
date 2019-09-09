Return-Path: <SRS0=hqT0=XE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 749AAC00307
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:42:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48AD32086D
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Sep 2019 09:42:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388525AbfIIJmA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Sep 2019 05:42:00 -0400
Received: from retiisi.org.uk ([95.216.213.190]:41300 "EHLO
        hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725818AbfIIJl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Sep 2019 05:41:59 -0400
Received: from valkosipuli.localdomain (valkosipuli.retiisi.org.uk [IPv6:2a01:4f9:c010:4572::80:2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.org.uk (Postfix) with ESMTPS id BE961634C87;
        Mon,  9 Sep 2019 12:41:54 +0300 (EEST)
Received: from sailus by valkosipuli.localdomain with local (Exim 4.92)
        (envelope-from <sakari.ailus@retiisi.org.uk>)
        id 1i7GBH-0000IX-Jk; Mon, 09 Sep 2019 12:41:55 +0300
Date:   Mon, 9 Sep 2019 12:41:55 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Jan Kotas <jank@cadence.com>
Cc:     Maxime Ripard <maxime.ripard@bootlin.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        Rafal Ciepiela <rafalc@cadence.com>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] media: Add support for Cadence CSI2RX 2.1
Message-ID: <20190909094155.GC843@valkosipuli.retiisi.org.uk>
References: <20190905105601.27034-1-jank@cadence.com>
 <20190905105601.27034-4-jank@cadence.com>
 <20190906080119.GF1586@valkosipuli.retiisi.org.uk>
 <A67221D2-8F92-4168-83D0-6B1325CA4417@global.cadence.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A67221D2-8F92-4168-83D0-6B1325CA4417@global.cadence.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jan,

On Mon, Sep 09, 2019 at 09:24:15AM +0000, Jan Kotas wrote:
> >> @@ -439,6 +535,9 @@ static int csi2rx_probe(struct platform_device *pdev)
> >> 	csi2rx->dev = &pdev->dev;
> >> 	mutex_init(&csi2rx->lock);
> >> 
> >> +	of_id = of_match_node(csi2rx_of_table, pdev->dev.of_node);
> >> +	csi2rx->vops = (struct csi2rx_vops *)of_id->data;
> > 
> > The cast isn't needed, is it?
> 
> It’s not, but doesn’t make it more readable?

If there's no need for it, please don't use explicit cast.

-- 
Sakari Ailus
