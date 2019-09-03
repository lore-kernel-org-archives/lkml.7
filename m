Return-Path: <SRS0=TDKO=W6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75303C3A5A7
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:15:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 583DF23431
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Sep 2019 14:15:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729550AbfICOPF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Sep 2019 10:15:05 -0400
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:56421 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729113AbfICOPF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Sep 2019 10:15:05 -0400
X-Originating-IP: 83.155.44.161
Received: from classic (mon69-7-83-155-44-161.fbx.proxad.net [83.155.44.161])
        (Authenticated sender: hadess@hadess.net)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id D2C496000C;
        Tue,  3 Sep 2019 14:15:01 +0000 (UTC)
Message-ID: <2505a7c3e29afb5a140ed47e54ea9c72d0192367.camel@hadess.net>
Subject: Re: [PATCH v6] HID: sb0540: add support for Creative SB0540 IR
 receivers
From:   Bastien Nocera <hadess@hadess.net>
To:     linux-input@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bastien Nocera <bnocera@redhat.com>
Date:   Tue, 03 Sep 2019 16:15:00 +0200
In-Reply-To: <20190702083931.7392-1-hadess@hadess.net>
References: <20190702083931.7392-1-hadess@hadess.net>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.4 (3.32.4-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

On Tue, 2019-07-02 at 10:39 +0200, Bastien Nocera wrote:
> From: Bastien Nocera <bnocera@redhat.com>
> 
> Add a new hid driver for the Creative SB0540 IR receiver. This
> receiver
> is usually coupled with an RM-1500 or an RM-1800 remote control.
> 
> The scrollwheels on the RM-1800 remote are not bound, as they are
> labelled for specific audio controls that don't usually exist on most
> systems. They can be remapped using standard Linux keyboard
> remapping tools.

I'm back from travelling, so ready to update/respin this patch if
needed.

Cheers

