Return-Path: <SRS0=ICIc=WW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE51FC3A59F
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AA15A2173E
	for <linux-kernel@archiver.kernel.org>; Mon, 26 Aug 2019 14:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfHZOCP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 26 Aug 2019 10:02:15 -0400
Received: from 195-159-176-226.customer.powertech.no ([195.159.176.226]:33260
        "EHLO blaine.gmane.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730327AbfHZOCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Aug 2019 10:02:15 -0400
Received: from list by blaine.gmane.org with local (Exim 4.89)
        (envelope-from <glk-linux-kernel-4@m.gmane.org>)
        id 1i2FZS-000nMf-Sb
        for linux-kernel@vger.kernel.org; Mon, 26 Aug 2019 16:02:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-kernel@vger.kernel.org
From:   =?UTF-8?Q?J=c3=b6rg-Volker_Peetz?= <jvpeetz@web.de>
Subject: Re: Linux 5.2.10
Date:   Mon, 26 Aug 2019 16:02:00 +0200
Message-ID: <8e4c772e-c0b7-c2d4-9301-67702c003dff@web.de>
References: <20190825144703.6518-1-sashal@kernel.org>
 <qju9bd$47qi$1@blaine.gmane.org> <20190825223537.GB5281@sasha-vm>
 <20190826043328.GB26547@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190826043328.GB26547@kroah.com>
Content-Language: de-DE-frami
Cc:     stable@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Message-ID: <20190826140200.n8pDG18Z0G0d_9tu36RYzgISKdNuSkrcUyGSxU4m2E4@z>

For me the command

$ gpg --receive-keys DEA66FF797772CDC

did the key import and I was able to verify the signature via
https://www.kernel.org/category/signatures.html
and then the git tag v5.2.10.

Thank you both very much.

Best regards,
Jörg.

