Return-Path: <SRS0=PPSE=ZM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FAKE_REPLY_C,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB1C43215
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FCCC22520
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Nov 2019 13:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574256396;
	bh=DsDYSq/DHhqcdU7x2gyp7R8L2zInP4Q/+ZwnP14xfC8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:List-ID:From;
	b=UEb826lIwf5b1aR5P8SztKvmlf1wotdTAbgjSWmVGrmCT8VkqCKKA9dy//ieQRqx8
	 3GDV/E8cYZ2Pq72EbjarmwjDXE+3lB41TakoWqahxOwO1BLLrKt8a6fg4XpQPEAjQa
	 AfEpxumgdA5QBALZeb4uOxyfRPWs1gYrk1JTAsnk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729456AbfKTN0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:38332 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727798AbfKTN0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Nov 2019 08:26:35 -0500
Received: from localhost (173-25-83-245.client.mchsi.com [173.25.83.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 64BE5224F3;
        Wed, 20 Nov 2019 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574256394;
        bh=DsDYSq/DHhqcdU7x2gyp7R8L2zInP4Q/+ZwnP14xfC8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=FIpUZW/KMEsdAr5Fm7S9pIXa746/f8Kgf29oYt4vjombJ0MJRjGbemJJlubK/KWoi
         WypaXCzNSSCcJypzI/5gFfbJKMGuBSYgTG1qL/ZdnU5W2CFaMheI4C/Ic/oRSA5qEB
         4Mu5JBq6dNUdYxiFeG9vDQJLutf59sizvVKdNICo=
Date:   Wed, 20 Nov 2019 07:26:33 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] PM / QoS: Wrap documentation to fit in 80 columns
Message-ID: <20191120132633.GA87581@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0gzspKm_Zy8JzWC54iPfJKU=2Hx_FzP-vLBS=CreyKgbA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 20, 2019 at 12:18:16PM +0100, Rafael J. Wysocki wrote:
> On Tue, Nov 19, 2019 at 3:09 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
> >
> > From: Bjorn Helgaas <bhelgaas@google.com>
> >
> > Wrap to 80 columns.  No textual change except to correct some "it's" that
> > should be "its".
> >
> > Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> Applied for 5.5, but I've dropped the "QoS" part from the subject, as
> this is not only about QoS.

Thank you!  Can't remember why I included "QoS" because it doesn't
make any sense.
