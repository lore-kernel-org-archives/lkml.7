Return-Path: <SRS0=Q+aa=S3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53838C10F03
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:33:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2130220675
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Apr 2019 09:33:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbfDYJdJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Apr 2019 05:33:09 -0400
Received: from gofer.mess.org ([88.97.38.141]:54649 "EHLO gofer.mess.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727891AbfDYJdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Apr 2019 05:33:08 -0400
Received: by gofer.mess.org (Postfix, from userid 1000)
        id 1861C60400; Thu, 25 Apr 2019 10:33:06 +0100 (BST)
Date:   Thu, 25 Apr 2019 10:33:06 +0100
From:   Sean Young <sean@mess.org>
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Michael Krufky <mkrufky@linuxtv.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andy Walls <awalls@md.metrocast.net>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-media@vger.kernel.org
Subject: Re: [PATCH v9 2/4] [media] cxusb: implement Medion MD95700 digital /
 analog coexistence
Message-ID: <20190425093305.jdu53bhmdwri23hv@gofer.mess.org>
References: <cover.1553903063.git.mail@maciej.szmigiero.name>
 <07fc8594c942ab527275b29121869ffe77bc1d83.1553903063.git.mail@maciej.szmigiero.name>
 <9ee14d2c-e8ea-5c3f-1194-f20f25678735@xs4all.nl>
 <75f07882-1553-b7d8-c15e-9e7cbc19996f@maciej.szmigiero.name>
 <fb8a5994-4eb7-11b0-d617-52ebecfe4ec0@xs4all.nl>
 <f673844e-e2a5-3d4c-df8a-eb71100b626d@maciej.szmigiero.name>
 <05dbc46f-d467-1f63-b1e6-16e4d65b1ac8@xs4all.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <05dbc46f-d467-1f63-b1e6-16e4d65b1ac8@xs4all.nl>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 25, 2019 at 09:26:05AM +0200, Hans Verkuil wrote:
> Sean, do you have cxusb hardware that you can use to test this when v11
> is posted? Just to verify that nothing breaks.

Sadly, I'm afraid I do not have any cxusb hardware.


Sean
