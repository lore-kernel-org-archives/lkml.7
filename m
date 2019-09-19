Return-Path: <SRS0=X8En=XO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E39CC3A5A6
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:56:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E937121924
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Sep 2019 08:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731957AbfISI4C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Sep 2019 04:56:02 -0400
Received: from relay-b03.edpnet.be ([212.71.1.220]:55229 "EHLO
        relay-b03.edpnet.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbfISI4B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Sep 2019 04:56:01 -0400
X-Greylist: delayed 899 seconds by postgrey-1.27 at vger.kernel.org; Thu, 19 Sep 2019 04:56:00 EDT
X-ASG-Debug-ID: 1568882456-0a88186e203bfccb0001-xx1T2L
Received: from zotac.vandijck-laurijssen.be (77.109.114.181.adsl.dyn.edpnet.net [77.109.114.181]) by relay-b03.edpnet.be with ESMTP id zku8b7QnzezzfzdY for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:40:56 +0200 (CEST)
X-Barracuda-Envelope-From: dev.kurt@vandijck-laurijssen.be
X-Barracuda-Effective-Source-IP: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Apparent-Source-IP: 77.109.114.181
Received: from x1.vandijck-laurijssen.be (x1.vandijck-laurijssen.be [IPv6:fd01::1a1d:eaff:fe02:d339])
        by zotac.vandijck-laurijssen.be (Postfix) with ESMTPSA id BA9E89DD3E5
        for <linux-kernel@vger.kernel.org>; Thu, 19 Sep 2019 10:40:56 +0200 (CEST)
Date:   Thu, 19 Sep 2019 10:40:53 +0200
From:   Kurt Van Dijck <dev.kurt@vandijck-laurijssen.be>
To:     linux-kernel@vger.kernel.org
Subject: Question on priorities with CAN
Message-ID: <20190919084053.GB1446@x1.vandijck-laurijssen.be>
X-ASG-Orig-Subj: Question on priorities with CAN
Mail-Followup-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.22 (2013-10-16)
X-Barracuda-Connect: 77.109.114.181.adsl.dyn.edpnet.net[77.109.114.181]
X-Barracuda-Start-Time: 1568882456
X-Barracuda-URL: https://212.71.1.220:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at edpnet.be
X-Barracuda-Scan-Msg-Size: 424
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.8881 1.0000 3.0996
X-Barracuda-Spam-Score: 3.10
X-Barracuda-Spam-Status: No, SCORE=3.10 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=7.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.76587
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

I work on a beaglebone-like board using the AM335x can chip, with an RT
kernel.

The can irq task is by default rt prio 50.
I have a process running on rt prio 10 using CAN_RAW socket.

I see that softirqd runs on regular timeslicing.
Do CAN frames need to pass through the softirqd in order to arrive
on my process?
I would need to elevate the softirqd's rt prio also in that case?

Kind regards,
Kurt
