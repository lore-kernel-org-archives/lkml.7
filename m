Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5786CC3A5A0
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D235206C1
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 19:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1566242918;
	bh=QdaNHabnQATTellUgHWaDEel6AzbE1D6DIER1HVExlI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=Vd+Sd+NmX09N9XsH2MoB+3jG32rJvIs1kloDmmLPDdUPdPwlhCyYIsllQ8GciOZja
	 vNkKyzRcwDpI0K3rTXL7mwmilger1fsvv39Bqu+2RxYrhnFCH2M/Fmjv9DFif06ctH
	 e1UKECZ3EWuP71LbUKAafbb49KD7Zodzt+s8fBQ8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728761AbfHST2h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 15:28:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:44210 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728398AbfHST2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 15:28:35 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 34A83206C1;
        Mon, 19 Aug 2019 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1566242915;
        bh=QdaNHabnQATTellUgHWaDEel6AzbE1D6DIER1HVExlI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gstHmsR7y4n8/TlcmRyVp7fpeg619sFIAkKdJrUKpyNuidXOZ0Lk2zQ9XdKBL/FiR
         00N2aI8kyV/WO18zFrtUiD0dqUqvPiLfCEpA1F6pZB9zvGSkLS1oDee6m9ucTCoITd
         /4ttCNaWSW8XhjqnWgVm5er0kEECob/R7MG9qKhQ=
Received: by mail-qk1-f178.google.com with SMTP id w18so2435458qki.0;
        Mon, 19 Aug 2019 12:28:35 -0700 (PDT)
X-Gm-Message-State: APjAAAUH3k+Gk8oEzqAmtxt1VhfmsXRvFormg2SiE5sP6AuSo4Ne/Bp5
        +kwSS05GcC03D736OK9HG0LOyxx8DamuV3OXdw==
X-Google-Smtp-Source: APXvYqwY6xx42yDW7hIjSnvmaPLBEK8bzXWhlEUDN0Ijfco/ERLYthPs7Knhxi9ySvKBporN0rhefJyOXaaPA2GTIdg=
X-Received: by 2002:a37:6944:: with SMTP id e65mr20546914qkc.119.1566242914448;
 Mon, 19 Aug 2019 12:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20190816205342.29552-1-jernej.skrabec@siol.net> <20190816205342.29552-2-jernej.skrabec@siol.net>
In-Reply-To: <20190816205342.29552-2-jernej.skrabec@siol.net>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 19 Aug 2019 14:28:23 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLWjtGWuVrTQs7ikAQ7vLu26rnkk=Vo0q9punj-fM+UGg@mail.gmail.com>
Message-ID: <CAL_JsqLWjtGWuVrTQs7ikAQ7vLu26rnkk=Vo0q9punj-fM+UGg@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: arm: sunxi: Add compatible for Tanix TX6 board
To:     Jernej Skrabec <jernej.skrabec@siol.net>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, devicetree@vger.kernel.org,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 16, 2019 at 3:54 PM Jernej Skrabec <jernej.skrabec@siol.net> wrote:
>
> Add new Oranth Tanix TX6 board compatible string to the bindings
> documentation.
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>
> ---
>  Documentation/devicetree/bindings/arm/sunxi.yaml | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
