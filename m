Return-Path: <SRS0=+RQC=WP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA658C3A59B
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:18:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CF562087E
	for <linux-kernel@archiver.kernel.org>; Mon, 19 Aug 2019 06:18:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nifty.com header.i=@nifty.com header.b="ohePG+Xr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726627AbfHSGSo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 19 Aug 2019 02:18:44 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:17677 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbfHSGSo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Aug 2019 02:18:44 -0400
Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50]) (authenticated)
        by conssluserg-03.nifty.com with ESMTP id x7J6Iagv004121;
        Mon, 19 Aug 2019 15:18:36 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com x7J6Iagv004121
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1566195517;
        bh=mdvVTv3n82OSRycPvJ85qAq0gYB/fIX4CdCh4wVf4wU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ohePG+XrOEPALXPBRFYCdboBGdtXD5/QyU5+0N0V8doa2luVnv5O0Oq7+M2erekaj
         dTAQXgcGDUtGIT9McHuO2Ts4PZL3Qpl8BDcN30PEc2LqL/NtGrpefCQlJUj+jo17/x
         fukbx5MosWL4V12eXBKWFQbyqQa5MzYPwv9yRW10RP0Igcb4NvLmPvXgOduwyKW7a0
         nWcUnzwfDjnjchry0/gKMabRmPLHie6QQ+Y/tCNKdVARrXBWCQHzuljkToyvGrcTmV
         sSlFn52BgebpLSdD2Zz776Poo/ELq5wTaUL0L7aHnDForC0pO77JGH21YQkuiI2hX7
         vbt8r2MvmhC6g==
X-Nifty-SrcIP: [209.85.217.50]
Received: by mail-vs1-f50.google.com with SMTP id b187so450674vsc.9;
        Sun, 18 Aug 2019 23:18:36 -0700 (PDT)
X-Gm-Message-State: APjAAAWRW0FmlcVMQjYxYk43hAKs0K3YDbpMCf/MkezhNyf7Ac0mzV1I
        aUF4nkeRkkXqlAmFEX+sROW2wHgs3ZsBWKIS21E=
X-Google-Smtp-Source: APXvYqypMbATPlyP1E6U0jX2apM4bwEbu+0F1IzcNo8Wg2XfSUc01fPlXGWMcGBZSfT+K7IwPTyid93NELceB+uKN0s=
X-Received: by 2002:a05:6102:20c3:: with SMTP id i3mr13217030vsr.155.1566195515660;
 Sun, 18 Aug 2019 23:18:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190621112306.17769-1-yamada.masahiro@socionext.com> <0e357fa8-3241-4ce4-fae7-d0ad36fb14c6@kernel.org>
In-Reply-To: <0e357fa8-3241-4ce4-fae7-d0ad36fb14c6@kernel.org>
From:   Masahiro Yamada <yamada.masahiro@socionext.com>
Date:   Mon, 19 Aug 2019 15:17:59 +0900
X-Gmail-Original-Message-ID: <CAK7LNASrdNwFEEFoy8mH4CnWHN5d8qCw_LeU1St0x1oa9jRNFQ@mail.gmail.com>
Message-ID: <CAK7LNASrdNwFEEFoy8mH4CnWHN5d8qCw_LeU1St0x1oa9jRNFQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: dts: socfpga: update to new Denali NAND binding
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        DTML <devicetree@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 25, 2019 at 12:39 AM Dinh Nguyen <dinguyen@kernel.org> wrote:
>
>
>
> On 6/21/19 6:23 AM, Masahiro Yamada wrote:
> > With commit d8e8fd0ebf8b ("mtd: rawnand: denali: decouple controller
> > and NAND chips"), the Denali NAND controller driver migrated to the
> > new controller/chip representation.
> >
> > Update DT for it.
> >
> > Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> > ---
> >
> >  arch/arm/boot/dts/socfpga.dtsi                |  2 +-
> >  arch/arm/boot/dts/socfpga_arria10.dtsi        |  2 +-
> >  .../boot/dts/socfpga_arria10_socdk_nand.dts   | 20 ++++++++++++-------
> >  3 files changed, 15 insertions(+), 9 deletions(-)
> >
>
> Applied! Thanks!
>
> Dinh


You did not send this to upstream for v5.3-rc1.

Which version is this aiming for?





-- 
Best Regards
Masahiro Yamada
