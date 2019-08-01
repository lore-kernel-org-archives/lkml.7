Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CA2FC32753
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:55:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DE8720838
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 13:55:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730397AbfHANz4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 09:55:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51158 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727537AbfHANzz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 09:55:55 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E9BF307D847;
        Thu,  1 Aug 2019 13:55:55 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4656E100032A;
        Thu,  1 Aug 2019 13:55:55 +0000 (UTC)
Received: from zmail21.collab.prod.int.phx2.redhat.com (zmail21.collab.prod.int.phx2.redhat.com [10.5.83.24])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 0E9571800202;
        Thu,  1 Aug 2019 13:55:55 +0000 (UTC)
Date:   Thu, 1 Aug 2019 09:55:55 -0400 (EDT)
From:   Vladis Dronov <vdronov@redhat.com>
To:     Greg KH <greg@kroah.com>
Cc:     Sasha Levin <sashal@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
Message-ID: <1983583259.6283500.1564667755023.JavaMail.zimbra@redhat.com>
In-Reply-To: <20190801135044.GB24791@kroah.com>
References: <20190730093345.25573-1-marcel@holtmann.org> <20190801133132.6BF30206A3@mail.kernel.org> <20190801135044.GB24791@kroah.com>
Subject: Re: [PATCH v5.3-rc2] Bluetooth: hci_uart: check for missing tty
 operations
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.43.2.29, 10.4.195.28]
Thread-Topic: Bluetooth: hci_uart: check for missing tty operations
Thread-Index: Q/MgTjXIhbDAEc0i/hiCMDLoceNcBw==
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Thu, 01 Aug 2019 13:55:55 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you, Greg!

I've just noticed the patch landed in the upstream and was going to start stable
backports, but it appeared you've already done this.

So, not only automated mailers are slow :)

Best regards,
Vladis Dronov | Red Hat, Inc. | The Core Kernel | Senior Software Engineer

----- Original Message -----
> From: "Greg KH" <greg@kroah.com>
> To: "Sasha Levin" <sashal@kernel.org>
> Cc: "Marcel Holtmann" <marcel@holtmann.org>, "Vladis Dronov" <vdronov@redhat.com>, torvalds@linux-foundation.org,
> linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org, stable@vger.kernel.org
> Sent: Thursday, August 1, 2019 3:50:44 PM
> Subject: Re: [PATCH v5.3-rc2] Bluetooth: hci_uart: check for missing tty operations
> 
> On Thu, Aug 01, 2019 at 01:31:31PM +0000, Sasha Levin wrote:
> > Hi,
> > 
> > [This is an automated email]
> > 
> > This commit has been processed because it contains a "Fixes:" tag,
> > fixing commit: .
> > 
> > The bot has tested the following trees: v5.2.4, v5.1.21, v4.19.62,
> > v4.14.134, v4.9.186, v4.4.186.
> > 
> > v5.2.4: Build OK!
> > v5.1.21: Build OK!
> > v4.19.62: Build OK!
> > v4.14.134: Failed to apply! Possible dependencies:
> >     25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")
> > 
> > v4.9.186: Failed to apply! Possible dependencies:
> >     25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")
> > 
> > v4.4.186: Failed to apply! Possible dependencies:
> >     162f812f23ba ("Bluetooth: hci_uart: Add Marvell support")
> >     25a13e382de2 ("bluetooth: hci_qca: Replace GFP_ATOMIC with GFP_KERNEL")
> >     395174bb07c1 ("Bluetooth: hci_uart: Add Intel/AG6xx support")
> >     9e69130c4efc ("Bluetooth: hci_uart: Add Nokia Protocol identifier")
> > 
> > 
> > NOTE: The patch will not be queued to stable trees until it is upstream.
> > 
> > How should we proceed with this patch?
> 
> Already fixed up by hand and queued up, your automated email is a bit
> slow :)
> 
> greg k-h
> 
