Return-Path: <SRS0=4ODY=VF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9C6C606BA
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 149972086D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jul 2019 13:52:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731530AbfGHNw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jul 2019 09:52:57 -0400
Received: from ms.lwn.net ([45.79.88.28]:51448 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727401AbfGHNw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jul 2019 09:52:57 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 888C02EF;
        Mon,  8 Jul 2019 13:52:56 +0000 (UTC)
Date:   Mon, 8 Jul 2019 07:52:55 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Phong Tran <tranmanphong@gmail.com>
Cc:     gregkh@linuxfoundation.org, skhan@linuxfoundation.org,
        mchehab@kernel.org, linux-kernel-mentees@lists.linuxfoundation.org,
        linux-usb@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation: usb: convert usb-help to rst
Message-ID: <20190708075255.0f337b28@lwn.net>
In-Reply-To: <20190705185519.31033-1-tranmanphong@gmail.com>
References: <20190705185519.31033-1-tranmanphong@gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  6 Jul 2019 01:55:19 +0700
Phong Tran <tranmanphong@gmail.com> wrote:

> Add new index.rst and change usb-help.txt format
> to rst.
> 
> Signed-off-by: Phong Tran <tranmanphong@gmail.com>

Thank you for working to make the kernel's documentation better.  That
said, I really don't think there is value in keeping this document.  It
hasn't been updated in any useful way in decades, contains broken links,
and the links that still work are full of obsolete information.  Honestly,
a better patch would, IMO, just delete this file.

Thanks,

jon
