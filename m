Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1929C388F3
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:41:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA1C420815
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 07:41:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733103AbfJAHlE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 03:41:04 -0400
Received: from relay-b02.edpnet.be ([212.71.1.222]:60097 "EHLO
        relay-b02.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733094AbfJAHlD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 03:41:03 -0400
X-ASG-Debug-ID: 1569915660-0a7b8d53c1e3e2f0001-xx1T2L
Received: from zotac.vandijck-laurijssen.be (77.109.119.18.adsl.dyn.edpnet.net [77.109.119.18]) by relay-b02.edpnet.be with ESMTP id C6MQQ4QsadEFXAAr; Tue, 01 Oct 2019 09:41:00 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Apparent-Source-IP: 77.109.119.18
Received: from x1.vandijck-laurijssen.be (74.250-240-81.adsl-static.isp.belgacom.be [81.240.250.74])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id 10B88A1D9DB;
        Tue,  1 Oct 2019 09:41:00 +0200 (CEST)
Date:   Tue, 1 Oct 2019 09:40:57 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     Jeroen Hofstee <jhofstee@victronenergy.com>
Cc:     "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] can: C_CAN: add bus recovery events
Message-ID: <20191001074057.GA28813@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Re: [PATCH 2/2] can: C_CAN: add bus recovery events
Mail-Followup-To: Jeroen Hofstee <jhofstee@victronenergy.com>,
        "linux-can@vger.kernel.org" <linux-can@vger.kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20190926085005.24805-1-jhofstee@victronenergy.com>
 <20190926085005.24805-3-jhofstee@victronenergy.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190926085005.24805-3-jhofstee@victronenergy.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.119.18.adsl.dyn.edpnet.net[77.109.119.18]
X-Barracuda-Start-Time: 1569915660
X-Barracuda-URL: https://212.71.1.222:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 484
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: SPAM GLOBAL 0.9983 1.0000 4.3232
X-Barracuda-Spam-Score: 4.32
X-Barracuda-Spam-Status: No, SCORE=4.32 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76991
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On do, 26 sep 2019 08:50:51 +0000, Jeroen Hofstee wrote:
> While the state is update when the error counters increase and decrease,
> there is no event when the bus recovers and the error counters decrease
> again. So add that event as well.
> 
> Change the state going downward to be ERROR_PASSIVE -> ERROR_WARNING ->
> ERROR_ACTIVE instead of directly to ERROR_ACTIVE again.

This looks like a proper thing to do
Acked-by: Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
