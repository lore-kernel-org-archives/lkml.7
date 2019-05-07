Return-Path: <SRS0=RyeP=TH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB6C0C004C9
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833E7204FD
	for <linux-kernel@archiver.kernel.org>; Tue,  7 May 2019 09:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbfEGJhP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 May 2019 05:37:15 -0400
Received: from mail1.bemta26.messagelabs.com ([85.158.142.3]:59407 "EHLO
        mail1.bemta26.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726286AbfEGJhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 May 2019 05:37:14 -0400
Received: from [85.158.142.103] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-3.bemta.az-a.eu-central-1.aws.symcld.net id 68/81-19557-7C151DC5; Tue, 07 May 2019 09:37:11 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrEIsWRWlGSWpSXmKPExsUyo1hfUvd44MU
  Ygw33NSw6D5xhtzjW9oTdonnxejaLy7vmsFksWtbK7MDqsWlVJ5vH/rlr2D0+b5Lz2Pv5N0sA
  SxRrZl5SfkUCa8aBFT8ZCz6wVdy5e5ipgfEZaxcjF4eQwBpGid+/frB3MXJy8AqYSMx+8okFx
  BYWsJPoXraCrYuRg4NNQFei644pSFhEQF5i1tuLjCA2s8AGRolFG8tAbBYBFYmnuyaDxTkFnC
  Q61k9lBWkVEnCUOHdFA6JcU6J1+2+wTRICGhIbbh5jgtgqKHFy5hMWiBp5ieats5khWmUljl6
  KhShXkDi7ZSIjhJ0kca7vCtsERoFZSKbOQjJpFpJJCxiZVzFaJhVlpmeU5CZm5ugaGhjoGhoa
  6xrpGpqb6SVW6SbqpZbqJqfmlRQlAmX1EsuL9Yorc5NzUvTyUks2MQLDP6WQacMOxmcL0w8xS
  nIwKYnyithfjBHiS8pPqcxILM6ILyrNSS0+xCjDwaEkwbszACgnWJSanlqRlpkDjESYtAQHj5
  II73KQNG9xQWJucWY6ROoUoy5H38Znc5mFWPLy81KlxHnFQIoEQIoySvPgRsCSwiVGWSlhXkY
  GBgYhnoLUotzMElT5V4ziHIxKwrxnQKbwZOaVwG16BXQEE9AR8zrOgRxRkoiQkmpgtPd9o2us
  OXlX4lOnownJZv9rnhScLjlaZpM9odbz2ru4Y/KedkI/FvZcfe/71PV4a9Xx7R0X7nx/+WE9m
  9BiPa41/Lobk6fnFr06strAJ0g4nl037Py78OnPf7kr6rIpNd+PYfYJ2npavFQtk2OGxJS6zU
  tnmTE7CyrtbBF58dLEIedWUZm9EktxRqKhFnNRcSIA5H11sAUDAAA=
X-Env-Sender: cst@phaseone.com
X-Msg-Ref: server-24.tower-228.messagelabs.com!1557221831!6022338!1
X-Originating-IP: [152.115.47.25]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.31.5; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 23581 invoked from network); 7 May 2019 09:37:11 -0000
Received: from unknown (HELO Exchange2.phaseone.com) (152.115.47.25)
  by server-24.tower-228.messagelabs.com with AES256-SHA encrypted SMTP; 7 May 2019 09:37:11 -0000
Received: from cstu16.phaseone.com (172.16.2.207) by Exchange2.phaseone.com
 (172.16.1.180) with Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 7 May
 2019 11:37:10 +0200
Message-ID: <1557221830.114189.8.camel@phaseone.com>
Subject: Re: [PATCH] usb: gadget: configfs: Add lpm_Ux_disable
From:   "Claus H. Stovgaard" <cst@phaseone.com>
To:     <linux-usb@vger.kernel.org>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        "Anurag Kumar Vulisha" <anurag.kumar.vulisha@xilinx.com>
Date:   Tue, 7 May 2019 11:37:10 +0200
In-Reply-To: <1557220655-123090-1-git-send-email-cst@phaseone.com>
References: <1557220655-123090-1-git-send-email-cst@phaseone.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.18.5.2-0ubuntu3.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.16.2.207]
X-ClientProxiedBy: Exchange3.phaseone.com (172.16.1.184) To
 Exchange2.phaseone.com (172.16.1.180)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2019-05-07 at 11:09 +0200, Claus H. Stovgaard wrote:
> When combining dwc3 with an redriver for a USB Type-C device
> solution, it
> sometimes have problems with leaving U1/U2 for certain hosts,
> resulting in
> link training errors and reconnects. This create an interface via
> configfs for disabling U1/U2, enabling a workaround for devices based
> on
> dwc3.
> 

Sorry messed up a bit with a missing cover letter.
This feature relates to Anurag patch [1] and a thread [2] from earlier 

Where Anurags patch focus on setting U1/U2 latency in the BOS
descriptor from the devicetree, this patch focuses on having a configfs
interface for forcing the UDC (here the dwc3) to not enable U1/U2 and
reject the SET_SEL(U1/U2).

Looking forward to input.

[1] https://www.spinics.net/lists/linux-usb/msg179732.html
[2] https://www.spinics.net/lists/linux-usb/msg179393.html

