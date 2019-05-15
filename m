Return-Path: <SRS0=FrXW=TP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EE05C04E53
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:46:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 221DC2084F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 May 2019 17:46:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727468AbfEORqa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 May 2019 13:46:30 -0400
Received: from smtprelay0223.hostedemail.com ([216.40.44.223]:58377 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726466AbfEORqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 13:46:30 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 018FE181D3368;
        Wed, 15 May 2019 17:46:29 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glass02_3861a3593ad33
X-Filterd-Recvd-Size: 1537
Received: from XPS-9350 (cpe-23-242-196-136.socal.res.rr.com [23.242.196.136])
        (Authenticated sender: joe@perches.com)
        by omf16.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 May 2019 17:46:27 +0000 (UTC)
Message-ID: <611968bf390bd6ab669ba7311eb06a1977f74ab3.camel@perches.com>
Subject: Re: [PATCH] staging: Add rtl8821ce PCIe WiFi driver
From:   Joe Perches <joe@perches.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Ping-Ke Shih <pkshih@realtek.com>,
        Realtek linux nic maintainers <nic_swsd@realtek.com>,
        Yan-Hsuan Chuang <yhchuang@realtek.com>
Date:   Wed, 15 May 2019 10:46:26 -0700
In-Reply-To: <20190515163945.GA5719@kroah.com>
References: <20190515112401.15373-1-kai.heng.feng@canonical.com>
         <20190515114022.GA18824@kroah.com>
         <6D5557B8-8140-48A8-BED7-9587936902D8@canonical.com>
         <20190515123319.GA435@kroah.com>
         <63833AA2-AC8B-4EEA-AF36-EF2A9BFD4F9F@canonical.com>
         <20190515163945.GA5719@kroah.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2019-05-15 at 18:39 +0200, Greg KH wrote:
> On Wed, May 15, 2019 at 09:06:44PM +0800, Kai-Heng Feng wrote:
> > 296 files changed, 206166 insertions(+)
> I'm not going to take another 200k lines for a simple wifi driver.

Good.

Realtek _really_ needs to improve the driver software.


