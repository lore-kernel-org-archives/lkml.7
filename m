Return-Path: <SRS0=bo2+=SE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB1B6C10F05
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:47:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA04920833
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Apr 2019 01:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1554169629;
	bh=TeCLzbefDrURBTLnxr1buRNSoDXrR5gYDlXtSNx/irM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=zclSjkQi5WM5gm0glBdqSDjLpTC3VKwPjxiZetD+HtethlVYm0dVEyHZMwj1LRL7t
	 ysnEzSGxLLlmdpmNQiIWpu57xm1lrE3knIRIWmX4hc3tbHl3MTC/dNfc2wYhGikrkI
	 li7GBkPtB5C1I05U6g8NUX595Ja4zn9QHMwjOpAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728756AbfDBBrI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 21:47:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:59362 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726635AbfDBBrI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 21:47:08 -0400
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 86AD020833;
        Tue,  2 Apr 2019 01:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1554169627;
        bh=TeCLzbefDrURBTLnxr1buRNSoDXrR5gYDlXtSNx/irM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=pSF2E0EpOqKpYvp++fvvEVLqOOekhK1QYwAgxBwpvz8juC4HB3DLv5OLpgGQG6o3Q
         vKQjAHgf3VqnFsz6R4S7ISQGDwFSRuUtNG/3V7La+98+htzMwH74eM/jB9JjDai/4o
         XSi1LuuPXSMLa3TMd5XvqBUR3GaX3GsQ3B0wttwc=
Received: by mail-qt1-f181.google.com with SMTP id d13so13418568qth.5;
        Mon, 01 Apr 2019 18:47:07 -0700 (PDT)
X-Gm-Message-State: APjAAAU/vXh63i/jC+hs9/c5/ddX8KYwa1ZKF78npHdr11EGJ07q7UQx
        dIS/7WNMGQpNEPaFhnrbVEyxRbIEb/SCEOBStA==
X-Google-Smtp-Source: APXvYqx1CK6jiAoPaxsReooDItUStPXHX2eYktfwPDlAKUY3YQlWqm/FNumtX50BjYuiuy5mfkBOgu6UujiRRJTODsQ=
X-Received: by 2002:aed:3e3d:: with SMTP id l58mr56810347qtf.77.1554169626812;
 Mon, 01 Apr 2019 18:47:06 -0700 (PDT)
MIME-Version: 1.0
References: <20190401173142.cunj5iwz2ox454qx@arbad>
In-Reply-To: <20190401173142.cunj5iwz2ox454qx@arbad>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 1 Apr 2019 20:46:54 -0500
X-Gmail-Original-Message-ID: <CAL_JsqKY2Sh=L7OZVHjovAq9YK0qubGKpRMezA+7H0b1Gq2oXA@mail.gmail.com>
Message-ID: <CAL_JsqKY2Sh=L7OZVHjovAq9YK0qubGKpRMezA+7H0b1Gq2oXA@mail.gmail.com>
Subject: Re: [PATCH v2] bmp085.yaml: transform DT documentation of iio sensor
 into YAML
To:     Andreas Klinger <ak@it-klinger.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        Brian Masney <masneyb@onstation.org>,
        "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 1, 2019 at 12:32 PM Andreas Klinger <ak@it-klinger.de> wrote:
>
> use bmp085.txt and change it into yaml format
>
> fix links to datasheets in replaced documentation
>
> Signed-off-by: Andreas Klinger <ak@it-klinger.de>
> ---
>  .../devicetree/bindings/iio/pressure/bmp085.txt    | 27 ---------
>  .../devicetree/bindings/iio/pressure/bmp085.yaml   | 70 ++++++++++++++++++++++
>  2 files changed, 70 insertions(+), 27 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.txt
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/bmp085.yaml

Reviewed-by: Rob Herring <robh@kernel.org>
