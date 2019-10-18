Return-Path: <SRS0=6OEZ=YL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2358ECA9EA0
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:16:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04FDD222C3
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Oct 2019 10:16:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438445AbfJRKQa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Oct 2019 06:16:30 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:46964 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732465AbfJRKQa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Oct 2019 06:16:30 -0400
Received: from 79.184.255.51.ipv4.supernova.orange.pl (79.184.255.51) (HELO kreacher.localnet)
 by serwer1319399.home.pl (79.96.170.134) with SMTP (IdeaSmtpServer 0.83.292)
 id 6845964ed128a594; Fri, 18 Oct 2019 12:16:27 +0200
From:   "Rafael J. Wysocki" <rjw@rjwysocki.net>
To:     Maximilian Luz <luzmaximilian@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Johan Hovold <johan@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Rob Herring <robh@kernel.org>,
        Jiri Slaby <jslaby@suse.com>, Len Brown <lenb@kernel.org>,
        linux-serial@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] serdev: Add ACPI devices by ResourceSource field
Date:   Fri, 18 Oct 2019 12:16:27 +0200
Message-ID: <2257692.4kSTgpFGC2@kreacher>
In-Reply-To: <84883ba0-ec01-9114-5c4a-e468cf85dfec@gmail.com>
References: <20190924162226.1493407-1-luzmaximilian@gmail.com> <03d11e04-aaad-4851-c7d6-feaf62793670@redhat.com> <84883ba0-ec01-9114-5c4a-e468cf85dfec@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, October 10, 2019 3:18:58 PM CEST Maximilian Luz wrote:
> Hi,
> 
> On 10/10/19 12:22 PM, Hans de Goede wrote:
> > This patch looks good to me and it works on my test hw with serial
> > attached BT HCI:
> > 
> > Reviewed-by: Hans de Goede <hdegoede@redhat.com>
> > Tested-by: Hans de Goede <hdegoede@redhat.com>
> > 
> > Regards,
> > 
> > Hans
> 
> Awesome, thank you!

Is anyone taking care of this patch, or should I do that?



