Return-Path: <SRS0=o7UO=TL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5935C04AB1
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:17:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C252720881
	for <linux-kernel@archiver.kernel.org>; Sat, 11 May 2019 18:17:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726283AbfEKSR4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 May 2019 14:17:56 -0400
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:38738 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfEKSR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 14:17:56 -0400
Received: from t60.musicnaut.iki.fi (85-76-18-95-nat.elisa-mobile.fi [85.76.18.95])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 0C90D300F5;
        Sat, 11 May 2019 21:17:53 +0300 (EEST)
Date:   Sat, 11 May 2019 21:17:53 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: Convert vendor prefixes to json-schema
Message-ID: <20190511181753.GA2444@t60.musicnaut.iki.fi>
References: <20190510194018.28206-1-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190510194018.28206-1-robh@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 10, 2019 at 02:40:18PM -0500, Rob Herring wrote:
> Convert the vendor prefix registry to a schema. This will enable checking
> that new vendor prefixes are added (in addition to the less than perfect
> checkpatch.pl check) and will also check against adding other prefixes
> which are not vendors.
> 
> Converted vendor-prefixes.txt using the following sed script:
> 
> sed -e 's/\([a-zA-Z0-9\-]*\)[[:space:]]*\([a-zA-Z0-9].*\)/  "^\1,\.\*\":\n    description: \2/'
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
[...]
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> deleted file mode 100644
> index e9034a6c003a..000000000000
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ /dev/null
> @@ -1,476 +0,0 @@
> -Device tree binding vendor prefix registry.  Keep list in alphabetical order.
[...]
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> new file mode 100644
> index 000000000000..be037fb2cada
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
> @@ -0,0 +1,975 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)

Is there a license change as well?

A.
