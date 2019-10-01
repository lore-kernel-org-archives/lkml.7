Return-Path: <SRS0=YRFP=X2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6114AC352AA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4144F21A4A
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Oct 2019 12:54:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388127AbfJAMy3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Oct 2019 08:54:29 -0400
Received: from ms.lwn.net ([45.79.88.28]:36478 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726464AbfJAMy3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Oct 2019 08:54:29 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 90B192CF;
        Tue,  1 Oct 2019 12:54:28 +0000 (UTC)
Date:   Tue, 1 Oct 2019 06:54:27 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     mchehab+samsung@kernel.org, rfontana@redhat.com,
        kstewart@linuxfoundation.org, gregkh@linuxfoundation.org,
        tglx@linutronix.de, bhelgaas@google.com, rppt@linux.ibm.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] scripts/sphinx-pre-install: add how to exit
 virtualenv usage message
Message-ID: <20191001065427.71af7b2b@lwn.net>
In-Reply-To: <20190919003754.4311-1-skhan@linuxfoundation.org>
References: <20190919003754.4311-1-skhan@linuxfoundation.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Sep 2019 18:37:54 -0600
Shuah Khan <skhan@linuxfoundation.org> wrote:

> Add usage message on how to exit the virtualenv after documentation
> work is done.
> 
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
> Changes since v1:
> Changed the message based on Mauro's review comments.

Applied, thanks.

jon
