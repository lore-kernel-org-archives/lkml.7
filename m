Return-Path: <SRS0=dUEL=RQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD4AC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:49:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 732CF205C9
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Mar 2019 15:49:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCMPtO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Mar 2019 11:49:14 -0400
Received: from smtprelay0241.hostedemail.com ([216.40.44.241]:60392 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725868AbfCMPtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Mar 2019 11:49:14 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 377E28368F00;
        Wed, 13 Mar 2019 15:49:12 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: knee28_15e6c8ea2a749
X-Filterd-Recvd-Size: 2259
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf18.hostedemail.com (Postfix) with ESMTPA;
        Wed, 13 Mar 2019 15:49:10 +0000 (UTC)
Message-ID: <dae1f4224eeaaf4eb6f3daeaf31d51af17a5b083.camel@perches.com>
Subject: Re: [PATCH 4/4] leds: lm3532: Introduce the lm3532 LED driver
From:   Joe Perches <joe@perches.com>
To:     Dan Murphy <dmurphy@ti.com>,
        Jacek Anaszewski <jacek.anaszewski@gmail.com>,
        robh+dt@kernel.org, pavel@ucw.cz, tony@atomide.com,
        lee.jones@linaro.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Date:   Wed, 13 Mar 2019 08:49:09 -0700
In-Reply-To: <c3743a0e-9efd-e179-098c-31b1242870b4@ti.com>
References: <20190307220947.20057-1-dmurphy@ti.com>
         <20190307220947.20057-4-dmurphy@ti.com>
         <8ac4d84f-c792-893d-fbae-fac88fac8631@gmail.com>
         <bb621d08-c192-0018-f67e-3f3262a71b6f@ti.com>
         <cf26b351-f2b5-8345-29b7-401153b5f0d7@gmail.com>
         <ee13f836-bd77-22b0-e230-2fc9050afe88@ti.com>
         <09ee942fb7be08c600c989217ad3abfe4b6702fd.camel@perches.com>
         <c3743a0e-9efd-e179-098c-31b1242870b4@ti.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.30.1-1build1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2019-03-11 at 12:47 -0500, Dan Murphy wrote:
> On 3/11/19 12:30 PM, Joe Perches wrote:
> > On Mon, 2019-03-11 at 12:24 -0500, Dan Murphy wrote:
> > > checkpatch takes issue with // in headers.
> > > Unless they have removed that requirement.
[]
> I guess I was referring to this SPDX warning
>  
> WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
> #1: FILE: drivers/net/can/m_can/m_can.h:1:
> +//SPDX-License-Identifier: GPL-2.0

The general form uses a space after the //

And much more recently:

commit fdf13693d370653013eec3bc7f80a3f535001bf0
Author: Joe Perches <joe@perches.com>
Date:   Thu Mar 7 16:28:32 2019 -0800

    checkpatch: verify SPDX comment style
    
    Using SPDX commenting style // or /* is specified for various file types
    in Documentation/process/license-rules.rst so add an appropriate test for
    .[chsS] files because many proposed file additions and patches do not use
    the correct style.


