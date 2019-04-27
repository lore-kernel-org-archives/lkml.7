Return-Path: <SRS0=SjSX=S5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C074EC43219
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:11:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9C1E92087C
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Apr 2019 12:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726362AbfD0MLI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Apr 2019 08:11:08 -0400
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:41888 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbfD0MLI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Apr 2019 08:11:08 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        by saturn.retrosnub.co.uk (Postfix; Retrosnub mail submission) with ESMTPSA id 29D079E8528;
        Sat, 27 Apr 2019 13:11:05 +0100 (BST)
Date:   Sat, 27 Apr 2019 13:11:03 +0100
From:   Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To:     Alexandre <amergnat@baylibre.com>
Cc:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        baylibre-upstreaming@groups.io
Subject: Re: [PATCH v2 3/3] iio: Add PAT9125 optical tracker sensor
Message-ID: <20190427131103.1ce00b1c@archlinux>
In-Reply-To: <8abd482d-ae1e-ba86-c050-317fc0208fe6@baylibre.com>
References: <1556016046-31231-1-git-send-email-amergnat@baylibre.com>
        <1556016046-31231-4-git-send-email-amergnat@baylibre.com>
        <alpine.DEB.2.21.1904231302210.24175@vps.pmeerw.net>
        <8abd482d-ae1e-ba86-c050-317fc0208fe6@baylibre.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 23 Apr 2019 16:06:56 +0200
Alexandre <amergnat@baylibre.com> wrote:

> Hi Peter,
> 
> On 4/23/19 13:33, Peter Meerwald-Stadler wrote:
> >
> > how is this thing different from a mouse device?  
> 
> I developed this driver to detect the board movement which can't be 
> detected by accelerometer (very slow motion). I admit this use case can 
> be handled by an input, and I'm agree with you, PAT9125 driver could be 
> an input. But this chip is able to track different kind of motion (flat 
> and rotation), and additionally have an interrupt GPIO, so using it like 
> input limit the driver potential. This chip is designed to work in 
> industrial measurement or embedded systems, and the IIO API match with 
> these environments, so IIO is the best way to exploit the entire 
> potential of this chip.
> 
> As I understand (from 
> https://www.kernel.org/doc/html/v4.12/input/event-codes.html#mice ), 
> mouse driver must report values when the device move. This feature 
> souldn't be mandatory for an optical tracker driver, specially for cases 
> where user prefers to use buffer or poll only when he need data.

Given the 'placement' of this driver isn't totally obvious, please
make sure to cc linux-input and Dmitry (maintainer) on V3.

Probably no one will mind, but the last thing we want is someone
else to put forward an input driver and we end up with two drivers
for the same thing.

Thanks,

Jonathan

> 
> All other comments will be fixed in V3.
> 
> Regards,
> 
> Alexandre
> 

