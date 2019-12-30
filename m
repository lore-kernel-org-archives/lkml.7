Return-Path: <SRS0=E66v=2U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01B8DC2D0D3
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 10:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C37B4206E4
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Dec 2019 10:16:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="tiXPWs3D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfL3KQm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Dec 2019 05:16:42 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:39672 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727322AbfL3KQm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Dec 2019 05:16:42 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id xBUAGbb8026580;
        Mon, 30 Dec 2019 04:16:37 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1577700997;
        bh=LrXW+SFGATb5Sj/EF03sI7JD005gvsuE2DUR/pXP8as=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=tiXPWs3DGsvXuq0KEjdb89VOdybf8EsESfiPMBHL7ZFCL0N0a0ft+STfO1yNJLGT1
         kB+F50PSjRho+TvOhm3OgCDwOTCybuYpomaOmsNWv2PNwSOsqF4vMXAom1bpfVNdFQ
         GLA+8N1kwpzXQqR7JCz+XIqQtfniFFrvFipBFsY0=
Received: from DFLE111.ent.ti.com (dfle111.ent.ti.com [10.64.6.32])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id xBUAGbE0126878
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 30 Dec 2019 04:16:37 -0600
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Mon, 30
 Dec 2019 04:16:37 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Mon, 30 Dec 2019 04:16:37 -0600
Received: from [10.24.69.159] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id xBUAGY8R038159;
        Mon, 30 Dec 2019 04:16:34 -0600
Subject: Re: [PATCH 2/3] dt-bindings: phy: Add lane<n>-mode property to WIZ
 (SERDES wrapper)
To:     Jyri Sarha <jsarha@ti.com>, Rob Herring <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Praneeth Bajjuri <praneeth@ti.com>,
        Yuti Amonkar <yamonkar@cadence.com>,
        Swapnil Kashinath Jakhade <sjakhade@cadence.com>,
        Roger Quadros <rogerq@ti.com>
References: <cover.1575906694.git.jsarha@ti.com>
 <fb79923b1591cc5f26b6973beb92ce503ad3f4d1.1575906694.git.jsarha@ti.com>
 <20191219190833.GA16358@bogus> <3cf64e30-6b4d-a138-7164-54d1cdc8e05a@ti.com>
 <CAL_JsqKNFbPebM=pC+GL_DMuf5OPZF4FyJ7KGdSonDAeL_3P1A@mail.gmail.com>
 <15d0bd42-5bb5-ee14-9e2a-7beb55671e8a@ti.com>
From:   Kishon Vijay Abraham I <kishon@ti.com>
Message-ID: <763b3a26-98bd-25c2-687b-e644c5bcb05b@ti.com>
Date:   Mon, 30 Dec 2019 15:48:34 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <15d0bd42-5bb5-ee14-9e2a-7beb55671e8a@ti.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 30/12/19 3:07 PM, Jyri Sarha wrote:
> On 24/12/2019 23:31, Rob Herring wrote:
>> On Fri, Dec 20, 2019 at 5:52 AM Jyri Sarha <jsarha@ti.com> wrote:
>>>
>>> On 19/12/2019 21:08, Rob Herring wrote:
>>>> On Mon, Dec 09, 2019 at 06:22:11PM +0200, Jyri Sarha wrote:
>>>>> Add property to indicate the usage of SERDES lane controlled by the
>>>>> WIZ wrapper. The wrapper configuration has some variation depending on
>>>>> how each lane is going to be used.
>>>>>
>>>>> Signed-off-by: Jyri Sarha <jsarha@ti.com>
>>>>> ---
>>>>>  .../devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 12 ++++++++++++
>>>>>  1 file changed, 12 insertions(+)
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>>> index 94e3b4b5ed8e..399725f65278 100644
>>>>> --- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>>> +++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
>>>>> @@ -97,6 +97,18 @@ patternProperties:
>>>>>        Torrent SERDES should follow the bindings specified in
>>>>>        Documentation/devicetree/bindings/phy/phy-cadence-dp.txt
>>>>>
>>>>> +  "^lane[1-4]-mode$":
>>>>> +    allOf:
>>>>> +      - $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +      - enum: [0, 1, 2, 3, 4, 5, 6]
>>>>> +    description: |
>>>>> +     Integer describing static lane usage for the lane indicated in
>>>>> +     the property name. For Sierra there may be properties lane0 and
>>>>> +     lane1, for Torrent all lane[1-4]-mode properties may be
>>>>> +     there. The constants to indicate the lane usage are defined in
>>>>> +     "include/dt-bindings/phy/phy.h". The lane is assumed to be unused
>>>>> +     if its lane<n>-use property does not exist.
>>>>
>>>> The defines were intended to be in 'phys' cells. Does putting both lane
>>>> and mode in the client 'phys' properties not work?
>>>>
>>>
>>> Let me first check if I understood you. So you are suggesting something
>>> like this:
>>>
>>> dp-phy {
>>>         #phy-cells = <5>; /* 1 for phy-type and 4 for lanes = 5 */
>>>         ...
>>> };
>>>
>>> dp-bridge {
>>>         ...
>>>         phys = <&dp-phy PHY_TYPE_DP 1 1 0 0>; /* lanes 0 and 1 for DP */
>>
>> Yes, but I think the lanes can be a single cell mask. And I'd probably
>> make that the first cell which is generally "which PHY" and make
>> type/mode the 2nd cell. I'd look for other users of PHY_TYPE_ defines
>> and match what they've done if possible.
>>
> 
> I see. This will cause some head ache on the driver implementation side,
> as there is no way for the phy driver to peek the lane use or type from
> the phy client's device tree node. It also looks to me that the phy
> API[1] has to be extended quite a bit before the phy client can pass the
> lane usage information to the phy driver. It will cause some pain to
> implement the extension without breaking the phy API and causing a nasty
> cross dependency over all the phy client domains.
> 
> Also, there is not much point in putting the PHY_TYPE constant to the
> phy client's node, as normally the phy client driver will know quite
> well what PHY_TYPE to use. E.g. a SATA driver will always select
> PHY_TYPE_SATA and a PCIE driver will select PHY_TYPE_PCIE, etc.
> 
> Kishon, if we have to take this road it also starts to sound like we
> will have to move the phy client's phandle to point to the phy wrapper
> node, if we want to keep the actual phy driver wrapper agnostic. Then we
> can make the wrapper to act like a proxy that forwards the phy_ops calls
> to the actual phy driver. Luckily the per lane phy-type selection is not
> a blocker for our j721e DisplayPort functionality.

WIZ is a PHY wrapper and not a PHY in itself. I'm not inclined in
modeling WIZ as a PHY and adding an additional level of indirection.
This can add more challenges w.r.t PHY sequencing and can also lead to
locking issues. That also doesn't accurately represent the HW bock.

Thanks
Kishon
