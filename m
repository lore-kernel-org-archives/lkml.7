Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2678AC10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F269B218B0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:40:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728723AbfDYJkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:40:05 -0400
Received: from mx.ungleich.ch ([185.203.112.16]:39638 "EHLO smtp.ungleich.ch"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727536AbfDYJkD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:40:03 -0400
X-Greylist: delayed 442 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Apr 2019 05:40:02 EDT
Received: from nico.schottelius.org (localhost [IPv6:::1])
        by smtp.ungleich.ch (Postfix) with ESMTP id 133882358E
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2019 11:32:39 +0200 (CEST)
Received: by nico.schottelius.org (Postfix, from userid 1000)
        id 0611D1A0100C; Thu, 25 Apr 2019 11:32:39 +0200 (CEST)
User-agent: mu4e 1.0; emacs 26.1
From:   Nico Schottelius <nico-kernel-20190425@schottelius.org>
To:     linux-kernel@vger.kernel.org
Subject: How to turn off IPv4 without disabling IPv6
Date:   Thu, 25 Apr 2019 11:32:38 +0200
Message-ID: <87pnpaqvk9.fsf@line.ungleich.ch>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Good morning kernel hackers,

we are a small company in Switzerland running some IPv6 only
networks. The systems in the IPv6 only networks do not need any IPv4
support anymore and thus for switches/routers we turned the support off.

Today we tried to turn off IPv4 in the Linux kernel at compile time.
But it seems that as soon as we turn off CONFIG_INET, CONFIG_IPV6 is
automatically turned off as well.

While you can argue that "turning off IPv4 is not necessary", this is
not our point. As IPv4 resources have depleted almost everywhere in the
world a move to IPv6 is inevitable, especially if you are a small
organisation offering Internet services.

Being a (new) small organisation you are already disadvantaged in terms of
IPv4 resources that you can afford, so our objective is to make the life
in the IPv6 world as easy as possible.

If we can build operating systems that don't run IPv4 anymore,
operators have at least a certain degree of complexity less and can
start fresh into adventures, without having to care about iptables,
about IPv4 routing, etc.

Coming back to my original question: is there a way or how would we turn
off IPv4 support in the Linux kernel? So far the only operating system
that is reported to be able to run without IPv4 is FreeBSD [0], but I
hope we can add more in the near future.

Best,

Nico

[0] https://ungleich.ch/en-us/cms/blog/2019/01/09/die-ipv4-die/

--
Your Swiss, Open Source and IPv6 Virtual Machine. Now on www.datacenterlight.ch.
