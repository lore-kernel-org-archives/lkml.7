Return-Path: <SRS0=c+yg=TC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B232C43219
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:25:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DDDB420873
	for <linux-kernel@archiver.kernel.org>; Thu,  2 May 2019 06:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfEBGZk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 May 2019 02:25:40 -0400
Received: from gate.crashing.org ([63.228.1.57]:38865 "EHLO gate.crashing.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725764AbfEBGZk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 May 2019 02:25:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
        by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x426PTu3022074;
        Thu, 2 May 2019 01:25:30 -0500
Message-ID: <79fbc203bc9fa09d88ab2c4bff8635be4c293d49.camel@kernel.crashing.org>
Subject: Re: [PATCH] driver core: Fix use-after-free and double free on glue
 directory
From:   Benjamin Herrenschmidt <benh@kernel.crashing.org>
To:     Muchun Song <smuchun@gmail.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org
Cc:     linux-kernel <linux-kernel@vger.kernel.org>, zhaowuyun@wingtech.com
Date:   Thu, 02 May 2019 09:25:29 +0300
In-Reply-To: <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
References: <20190423143258.96706-1-smuchun@gmail.com>
         <24b0fff3775147c04b006282727d94fea7f408b4.camel@kernel.crashing.org>
         <CAPSr9jHhwASv7=83hU+81mC0JJyuyt2gGxLmyzpCOfmc9vKgGQ@mail.gmail.com>
         <a37e7a49c3e7fa6ece2be2b76798fef3e51ade4e.camel@kernel.crashing.org>
         <CAPSr9jHCVCHNK+AmKkUBgs4dPC0UC5KdYKqMinkauyL3OL6qrQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2019-04-28 at 22:49 +0800, Muchun Song wrote:
> Hi Greg and Rafael:
> 
> 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> 于2019年4月28日周日
> 下午6:10写道：
> > 
> > The basic idea yes, the whole bool *locked is horrid though.
> > Wouldn't it
> > work to have a get_device_parent_locked that always returns with
> > the mutex held,
> > or just move the mutex to the caller or something simpler like this
> > ?
> > 
> 
> Greg and Rafael, do you have any suggestions for this? Or you also
> agree with Ben?

Ping guys ? This is worth fixing... 

Ben.

