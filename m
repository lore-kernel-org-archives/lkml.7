Return-Path: <SRS0=0SVE=WF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02D77C31E40
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CA7832173E
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Aug 2019 09:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="khf7FwrO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406166AbfHIJa4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Aug 2019 05:30:56 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:32877 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727063AbfHIJa4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Aug 2019 05:30:56 -0400
Received: by mail-qt1-f177.google.com with SMTP id v38so2769051qtb.0
        for <linux-kernel@vger.kernel.org>; Fri, 09 Aug 2019 02:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=pf61PqN6dZ7xwejrqX8UsVfPlb8KycDCKtziC5JrmJg=;
        b=khf7FwrOnMEguYXOSLJ2FXRJNEoFOvkMqhCjiw8gbOutjfD/DtgAOSXgVM1f8AiIXt
         iXI6BOkLLBRYmbrBfP4lYPnN6T80bwFHf2Fs7Cfd2xHRRblmi7/32CVk51V8mOswZicD
         h7D7JFsQiILCWMa0ujAc1ghByUwmWb+NzeWY1yKm52e3ITdt8LldgIVOQwD+TxtPQLBP
         tMWRfwkLNFi6Oyr1okdpusc0MHKxadRCTgGDGtlBWyDnjrIHAG3x6z7HBOItFQg+2yrz
         DZ0eHLbrwHlll0gVDHZRYu2pH+OLT8DagEtYJn2Z/AKxv4l4tZQ/Mnyc20A7cvnpaYju
         c4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=pf61PqN6dZ7xwejrqX8UsVfPlb8KycDCKtziC5JrmJg=;
        b=Vr1j5nzdiZNQqokWHmf8UaUsm7fcflwSe01mM9xz+SPMPfDtA6bmj2qK29jQwg6ugg
         xMcpUNDju2jKLIwODM3LKXKpHl0/9wn2S2QAxsXm+swtaSBAkxQeGu2PHtHaE8kDqo+z
         LyuNH0YY6VeubDb6K2UzwPHRJLEKy0VYzbXRbU03tfT0Md4mHZzY4GXIu+Novw3wppgK
         8NTsmGtogdkI/ywVT9bjsVpkxln+VOiowY712lOYzs36Foa6r/mVMUsqxzmMw3Vc9DVM
         oYhRR5fVDd2jI4k6bEb7lDT3kI4aFLmFbvRXHHzWKVYqtSaaMriXqr61DzXusKAVC9qf
         d//Q==
X-Gm-Message-State: APjAAAWqLbwbb7PwDY2OpkQS8DFew6CHaC2Zagh6DvwwcVAIrMQY8z9h
        f3zUSmTevi2oqDijEtkI4TyyoKr8dv0VBejW82Fd5OaF
X-Google-Smtp-Source: APXvYqyQgsbUtkWJuScrtBxZEe1LdJEnF7HBQmJ3CdpmvJ+G3EYVb/ceWHxec1DKdp5nsjVQdG9Eawp+z8wq8RbKvoo=
X-Received: by 2002:ac8:1a6c:: with SMTP id q41mr14680589qtk.217.1565343055018;
 Fri, 09 Aug 2019 02:30:55 -0700 (PDT)
MIME-Version: 1.0
From:   Charlemagne Lasse <charlemagnelasse@gmail.com>
Date:   Fri, 9 Aug 2019 11:30:44 +0200
Message-ID: <CAFGhKbwJVv23Mwd7ruo8JCC-0U3BdNRwnxih9zgFSCyPe=jnoA@mail.gmail.com>
Subject: REUSE/SPDX: Invalid LicenseRef in Linux sources
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Basil Peace <grv87@yandex.ru>,
        Carmen Bianca Bakker <carmen@carmenbianca.eu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Maxwell <keith.maxwell@gmail.com>,
        =?UTF-8?Q?Matija_=C5=A0uklje?= <matija.suklje@liferay.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When I run the reuse lint tool on the current linux sources, I get
following error

reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/deprecated/GPL-1.0, resolving to LicenseRef-Unknown0
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/exceptions/GCC-exception-2.0, resolving to
LicenseRef-Unknown1
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/preferred/LGPL-2.0, resolving to LicenseRef-Unknown2
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/preferred/LGPL-2.1, resolving to LicenseRef-Unknown3
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/preferred/GPL-2.0, resolving to LicenseRef-Unknown4
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/dual/Apache-2.0, resolving to LicenseRef-Unknown5
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/dual/MPL-1.1, resolving to LicenseRef-Unknown6
reuse.project - WARNING - Could not resolve SPDX identifier of
LICENSES/dual/CDDL-1.0, resolving to LicenseRef-Unknown7

Can you please help to fix the problem

Thanks
