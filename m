Return-Path: <SRS0=/BGd=SD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65CA5C43381
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:16:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C8820896
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Apr 2019 16:16:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728567AbfDAQQU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Apr 2019 12:16:20 -0400
Received: from ns.iliad.fr ([212.27.33.1]:36532 "EHLO ns.iliad.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726985AbfDAQQU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Apr 2019 12:16:20 -0400
Received: from ns.iliad.fr (localhost [127.0.0.1])
        by ns.iliad.fr (Postfix) with ESMTP id EAFF821197;
        Mon,  1 Apr 2019 18:16:18 +0200 (CEST)
Received: from [192.168.108.8] (freebox.vlq16.iliad.fr [213.36.7.13])
        by ns.iliad.fr (Postfix) with ESMTP id D44F81FF1D;
        Mon,  1 Apr 2019 18:16:18 +0200 (CEST)
Subject: Re: [PATCH v6 1/2] Bluetooth: hci_qca: Added support for WCN3998
To:     Harish Bandi <c-hbandi@codeaurora.org>
References: <1553689723-21017-1-git-send-email-c-hbandi@codeaurora.org>
 <1553689723-21017-2-git-send-email-c-hbandi@codeaurora.org>
Cc:     MSM <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>
From:   Marc Gonzalez <marc.w.gonzalez@free.fr>
Message-ID: <5f944a7f-976d-bc16-3f07-d65d0aecb732@free.fr>
Date:   Mon, 1 Apr 2019 18:16:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <1553689723-21017-2-git-send-email-c-hbandi@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: ClamAV using ClamSMTP ; ns.iliad.fr ; Mon Apr  1 18:16:19 2019 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2019 13:28, Harish Bandi wrote:

> +bool qca_is_wcn399x(enum qca_btsoc_type soc_type)
> +{
> +	if ((soc_type == QCA_WCN3990) || (soc_type == QCA_WCN3998))
> +		return true;
> +
> +	return false;
> +}

Dunno if you saw my earlier comment.

The above is not very idiomatic. I would write:

bool is_qca_soc_type_wcn399x_family(enum qca_btsoc_type soc_type)
{
	return soc_type == QCA_WCN3990 || soc_type  == QCA_WCN3998;
}

Regards.
