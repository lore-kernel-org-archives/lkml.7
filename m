Return-Path: <SRS0=95/N=R6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 626AEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:35:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 348FC2075E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 Mar 2019 09:35:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732757AbfC0JfF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 Mar 2019 05:35:05 -0400
Received: from mx2.suse.de ([195.135.220.15]:54490 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726237AbfC0JfF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Mar 2019 05:35:05 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A05C9AC43;
        Wed, 27 Mar 2019 09:35:03 +0000 (UTC)
Message-ID: <1553679302.14990.0.camel@suse.com>
Subject: Re: [PATCH v3] HID: core: move Usage Page concatenation to Main item
From:   Oliver Neukum <oneukum@suse.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Terry.Junge@plantronics.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 27 Mar 2019 10:35:02 +0100
In-Reply-To: <20190326200331.25934-1-nsaenzjulienne@suse.de>
References: <20190326200331.25934-1-nsaenzjulienne@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Di, 2019-03-26 at 21:03 +0100, Nicolas Saenz Julienne wrote:
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -218,13 +218,14 @@ static unsigned hid_lookup_collection(struct hid_parser *parser, unsigned type)
>   * Add a usage to the temporary parser table.
>   */
>  
> -static int hid_add_usage(struct hid_parser *parser, unsigned usage)
> +static int hid_add_usage(struct hid_parser *parser, unsigned usage, __u8 size)

No need to use the __u8 style inside the kernel. u8 will do.

	Regards
		Oliver

