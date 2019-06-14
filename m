Return-Path: <SRS0=TKbG=UN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 559B5C31E4B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:07:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 352482183F
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Jun 2019 17:07:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726392AbfFNRHr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Jun 2019 13:07:47 -0400
Received: from mx2.suse.de ([195.135.220.15]:44526 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726028AbfFNRHq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jun 2019 13:07:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 28740AF10;
        Fri, 14 Jun 2019 17:07:45 +0000 (UTC)
Subject: Re: [PATCH v3] dt-bindings: arm: Convert Actions Semi bindings to
 jsonschema
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
References: <20190517153223.7650-1-robh@kernel.org>
 <20190613224435.GA32572@bogus> <20190614170450.GA29654@Mani-XPS-13-9360>
From:   =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Openpgp: preference=signencrypt
Organization: SUSE Linux GmbH
Message-ID: <5946467c-7674-de2b-a657-627cf3be42df@suse.de>
Date:   Fri, 14 Jun 2019 19:07:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190614170450.GA29654@Mani-XPS-13-9360>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 14.06.19 um 19:04 schrieb Manivannan Sadhasivam:
> On Thu, Jun 13, 2019 at 04:44:35PM -0600, Rob Herring wrote:
>> On Fri, May 17, 2019 at 10:32:23AM -0500, Rob Herring wrote:
>>> Convert Actions Semi SoC bindings to DT schema format using json-schema.
>>>
>>> Cc: "Andreas Färber" <afaerber@suse.de>
>>> Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
>>> Cc: Mark Rutland <mark.rutland@arm.com>
>>> Cc: linux-arm-kernel@lists.infradead.org
>>> Cc: devicetree@vger.kernel.org
>>> Signed-off-by: Rob Herring <robh@kernel.org>
>>> ---
>>> v3:
>>> - update MAINTAINERS
>>>
>>>  .../devicetree/bindings/arm/actions.txt       | 56 -------------------
>>>  .../devicetree/bindings/arm/actions.yaml      | 38 +++++++++++++
>>>  MAINTAINERS                                   |  2 +-
>>>  3 files changed, 39 insertions(+), 57 deletions(-)
>>>  delete mode 100644 Documentation/devicetree/bindings/arm/actions.txt
>>>  create mode 100644 Documentation/devicetree/bindings/arm/actions.yaml
>>
>> Ping. Please apply or modify this how you'd prefer. I'm not going to 
>> keep respinning this.
>>
> 
> Sorry for that Rob.

Well, it was simply not clear whether we were supposed to or not. :)

> Andreas, are you going to take this patch? Else I'll pick it up (If you
> want me to do the PR for next cycle)

I had checked that all previous changes to the .txt file were by myself,
so I would prefer if we not license it under GPLv2-only but under the
same dual-license (MIT/GPLv2+) as the DTs. That modification would need
Rob's approval then.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah
HRB 21284 (AG Nürnberg)
