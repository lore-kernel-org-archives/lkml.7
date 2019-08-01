Return-Path: <SRS0=wo+8=V5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93463C433FF
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63ECC20644
	for <linux-kernel@archiver.kernel.org>; Thu,  1 Aug 2019 09:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=kolabnow.com header.i=@kolabnow.com header.b="ZAp73Aom"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbfHAJiF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 1 Aug 2019 05:38:05 -0400
Received: from mx.kolabnow.com ([95.128.36.42]:23352 "EHLO mx.kolabnow.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725790AbfHAJiF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Aug 2019 05:38:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTP id 80C29404BA;
        Thu,  1 Aug 2019 11:38:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kolabnow.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:message-id:date:date:subject:subject
        :from:from:received:received:received; s=dkim20160331; t=
        1564652281; x=1566466682; bh=aC1zXoQ9mU5ArfgbwuVk+EggHbZS/Kn1AQ9
        zYKAWWzY=; b=ZAp73AomL9UNhXSPy8zkjk+szZJFCc6yjuCOZVYnDynQVYklTVa
        ElvIkMZ3bpgt+YdJTpLZ4OHH/rvYG2VlJ8HdMzHhwzBlZYySmBOOLZMETSo5RLPD
        RMqyCf0BKbSd9jAEU7ebgvSCSMqNzCdBQZs19KDNg+wsek4aegLGHTeiYNXPDeUn
        lKv0MhDfuu0bQfyiTXTkJHfYH4mlyA4XRJ6jB3BlHM7w2gpkjBNq8LrqAhsLbid7
        AavGHYgQlJkcJlqHqTPWlHSgYFuhzsC69q02ULsFe93YR+KEZLbeFlxwaZ/Nrrh/
        O1UIkVoXx6t01OjPpPmM72Oi7ld7Ejlkkcra6XIwbgzgZMp2hcB9NwHGSdh/Kr2S
        TU+XzbG7/XFx0vv3Ji4SiDWndS4yhKWbyyIJsGQOBNxEL28pCjWdwkakybb0eGh5
        ZhRciDwqrqqLsxnHhY5PxHfRGwLCwQErpIXj7Iys7647USCkMZf3qwuDhqUtemtf
        +g0rNnyhvebNfDZ1tTg74ac1xfS4SILA5PNZXxyUtdjoVGjdKRD4r+24nk/rVBp0
        YkFIuxlXa6qqc8RGDAPlq1lHiROMiCebPJHECURsRannteI9GZqIWJk0LwoC4uER
        K1+W3S0xXweMJ9pNWvgTavO4umxLTq3FhhljMnUkWritkXyLNGh7biIQ=
X-Virus-Scanned: amavisd-new at mykolab.com
Received: from mx.kolabnow.com ([127.0.0.1])
        by localhost (ext-mx-out003.mykolab.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id OQLc090K_CnM; Thu,  1 Aug 2019 11:38:01 +0200 (CEST)
Received: from int-mx003.mykolab.com (unknown [10.9.13.3])
        by ext-mx-out003.mykolab.com (Postfix) with ESMTPS id 4AAE440404;
        Thu,  1 Aug 2019 11:38:01 +0200 (CEST)
Received: from ext-subm002.mykolab.com (unknown [10.9.6.2])
        by int-mx003.mykolab.com (Postfix) with ESMTPS id A35AE3555;
        Thu,  1 Aug 2019 11:38:00 +0200 (CEST)
From:   Federico Vaga <federico.vaga@vaga.pv.it>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alessia Mantegazza <amantegazza@vaga.pv.it>
Subject: Re: [PATCH] doc:it_IT: translations for documents in process/
Date:   Thu, 01 Aug 2019 11:37:58 +0200
Message-ID: <20864529.Q1CKeA7GMu@pcbe13614>
In-Reply-To: <20190731125124.46e06ab6@lwn.net>
References: <20190728092054.1183-1-federico.vaga@vaga.pv.it> <20190731125124.46e06ab6@lwn.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, July 31, 2019 8:51:24 PM CEST Jonathan Corbet wrote:
> On Sun, 28 Jul 2019 11:20:54 +0200
> 
> Federico Vaga <federico.vaga@vaga.pv.it> wrote:
> > From: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > 
> > Translations for the following documents in process/:
> >     - email-clients
> >     - management-style
> > 
> > Signed-off-by: Alessia Mantegazza <amantegazza@vaga.pv.it>
> > Signed-off-by: Federico Vaga <federico.vaga@vaga.pv.it>
> 
> This looks generally good, but I have to ask...
> 
> > +Se la patch che avete inserito dev'essere modificata usato la finestra di
> > +scrittura di Claws, allora assicuratevi che l'"auto-interruzione" sia
> > +disabilitata
> > :menuselection:`Configurazione-->Preferenze-->Composizione-->Interruzione
> > riga`.
> Have you actually verified that the translations used in these mail
> clients matches what you have here?

Yep, I've installed all of them and gone through all menus.
But I just noticed a typo in the quoted statement, I will send a new patch:

"modificata usato" -> "modificata usando"

> 
> Thanks,
> 
> jon


-- 
Federico Vaga
http://www.federicovaga.it/


