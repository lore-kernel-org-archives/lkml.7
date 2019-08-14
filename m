Return-Path: <SRS0=cDsG=WK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1622C433FF
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BD05E214C6
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Aug 2019 22:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728451AbfHNWUn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Aug 2019 18:20:43 -0400
Received: from foss.arm.com ([217.140.110.172]:34456 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726221AbfHNWUn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Aug 2019 18:20:43 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DF4B9344;
        Wed, 14 Aug 2019 15:20:41 -0700 (PDT)
Received: from [10.1.196.61] (tuskha01.cambridge.arm.com [10.1.196.61])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA56B3F718;
        Wed, 14 Aug 2019 15:20:40 -0700 (PDT)
Subject: Re: [PATCH 1/4] mailbox: arm_mhuv2: add device tree binding
 documentation
To:     Jassi Brar <jassisinghbrar@gmail.com>,
        Morten Borup Petersen <morten_bp@live.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "tushar.2nov@gmail.com" <tushar.2nov@gmail.com>,
        "nd@arm.com" <nd@arm.com>,
        Morten Borup Petersen <morten.petersen@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Devicetree List <devicetree@vger.kernel.org>
References: <20190717192616.1731-1-tushar.khandelwal@arm.com>
 <20190717192616.1731-2-tushar.khandelwal@arm.com>
 <CABb+yY04vW-i35N6P57KSKgmMAYkrA2CDyUvA-bLCZMxiZaocw@mail.gmail.com>
 <CABb+yY1SeHTgZQNAHJW+dZG=khah5c5igtKy+MrjADnZF29Aow@mail.gmail.com>
 <VI1PR0601MB21113C48E719B2C79EC2FE508FC20@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3yMWbUiQnJgfQhwnW1OM3aoFL3ZFc018E-fxGichi-4Q@mail.gmail.com>
 <VI1PR0601MB2111A5A4E951F011D389A8978FD90@VI1PR0601MB2111.eurprd06.prod.outlook.com>
 <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
From:   "tushar.khandelwal@arm.com" <tushar.khandelwal@arm.com>
Message-ID: <685d5c73-42e6-3de4-f607-e8c7f5678bf2@arm.com>
Date:   Wed, 14 Aug 2019 23:20:39 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <CABb+yY3Ni7wV+ui1LO7TERWQH_BoakZbPq961wdRPB4X-nwS2A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/08/2019 17:36, Jassi Brar wrote:
> On Fri, Aug 2, 2019 at 5:41 AM Morten Borup Petersen <morten_bp@live.dk> wrote:
>>
>>
>>
>> On 7/31/19 9:31 AM, Jassi Brar wrote:
>>> On Sun, Jul 28, 2019 at 4:28 PM Morten Borup Petersen <morten_bp@live.dk> wrote:
>>>>
>>>>
>>>>
>>>> On 7/25/19 7:49 AM, Jassi Brar wrote:
>>>>> On Sun, Jul 21, 2019 at 4:58 PM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>>>>>>
>>>>>> On Wed, Jul 17, 2019 at 2:26 PM Tushar Khandelwal
>>>>>> <tushar.khandelwal@arm.com> wrote:
>>>>>>
>>>>>>> diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
>>>>>>> new file mode 100644
>>>>>>> index 000000000000..3a05593414bc
>>>>>>> --- /dev/null
>>>>>>> +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.txt
>>>>>>> @@ -0,0 +1,108 @@
>>>>>>> +Arm MHUv2 Mailbox Driver
>>>>>>> +========================
>>>>>>> +
>>>>>>> +The Arm Message-Handling-Unit (MHU) Version 2 is a mailbox controller that has
>>>>>>> +between 1 and 124 channel windows to provide unidirectional communication with
>>>>>>> +remote processor(s).
>>>>>>> +
>>>>>>> +Given the unidirectional nature of the device, an MHUv2 mailbox may only be
>>>>>>> +written to or read from. If a pair of MHU devices is implemented between two
>>>>>>> +processing elements to provide bidirectional communication, these must be
>>>>>>> +specified as two separate mailboxes.
>>>>>>> +
>>>>>>> +A device tree node for an Arm MHUv2 device must specify either a receiver frame
>>>>>>> +or a sender frame, indicating which end of the unidirectional MHU device which
>>>>>>> +the device node entry describes.
>>>>>>> +
>>>>>>> +An MHU device must be specified with a transport protocol. The transport
>>>>>>> +protocol of an MHU device determines the method of data transmission as well as
>>>>>>> +the number of provided mailboxes.
>>>>>>> +Following are the possible transport protocol types:
>>>>>>> +- Single-word: An MHU device implements as many mailboxes as it
>>>>>>> +               provides channel windows. Data is transmitted through
>>>>>>> +               the MHU registers.
>>>>>>> +- Multi-word:  An MHU device implements a single mailbox. All channel windows
>>>>>>> +               will be used during transmission. Data is transmitted through
>>>>>>> +               the MHU registers.
>>>>>>> +- Doorbell:    An MHU device implements as many mailboxes as there are flag
>>>>>>> +               bits available in its channel windows. Optionally, data may
>>>>>>> +               be transmitted through a shared memory region, wherein the MHU
>>>>>>> +               is used strictly as an interrupt generation mechanism.
>>>>>>> +
>>>>>>> +Mailbox Device Node:
>>>>>>> +====================
>>>>>>> +
>>>>>>> +Required properties:
>>>>>>> +--------------------
>>>>>>> +- compatible:  Shall be "arm,mhuv2" & "arm,primecell"
>>>>>>> +- reg:         Contains the mailbox register address range (base
>>>>>>> +               address and length)
>>>>>>> +- #mbox-cells  Shall be 1 - the index of the channel needed.
>>>>>>> +- mhu-frame    Frame type of the device.
>>>>>>> +               Shall be either "sender" or "receiver"
>>>>>>> +- mhu-protocol Transport protocol of the device. Shall be one of the
>>>>>>> +               following: "single-word", "multi-word", "doorbell"
>>>>>>> +
>>>>>>> +Required properties (receiver frame):
>>>>>>> +-------------------------------------
>>>>>>> +- interrupts:  Contains the interrupt information corresponding to the
>>>>>>> +               combined interrupt of the receiver frame
>>>>>>> +
>>>>>>> +Example:
>>>>>>> +--------
>>>>>>> +
>>>>>>> +       mbox_mw_tx: mhu@10000000 {
>>>>>>> +               compatible = "arm,mhuv2","arm,primecell";
>>>>>>> +               reg = <0x10000000 0x1000>;
>>>>>>> +               clocks = <&refclk100mhz>;
>>>>>>> +               clock-names = "apb_pclk";
>>>>>>> +               #mbox-cells = <1>;
>>>>>>> +               mhu-protocol = "multi-word";
>>>>>>> +               mhu-frame = "sender";
>>>>>>> +       };
>>>>>>> +
>>>>>>> +       mbox_sw_tx: mhu@10000000 {
>>>>>>> +               compatible = "arm,mhuv2","arm,primecell";
>>>>>>> +               reg = <0x11000000 0x1000>;
>>>>>>> +               clocks = <&refclk100mhz>;
>>>>>>> +               clock-names = "apb_pclk";
>>>>>>> +               #mbox-cells = <1>;
>>>>>>> +               mhu-protocol = "single-word";
>>>>>>> +               mhu-frame = "sender";
>>>>>>> +       };
>>>>>>> +
>>>>>>> +       mbox_db_rx: mhu@10000000 {
>>>>>>> +               compatible = "arm,mhuv2","arm,primecell";
>>>>>>> +               reg = <0x12000000 0x1000>;
>>>>>>> +               clocks = <&refclk100mhz>;
>>>>>>> +               clock-names = "apb_pclk";
>>>>>>> +               #mbox-cells = <1>;
>>>>>>> +               interrupts = <0 45 4>;
>>>>>>> +               interrupt-names = "mhu_rx";
>>>>>>> +               mhu-protocol = "doorbell";
>>>>>>> +               mhu-frame = "receiver";
>>>>>>> +       };
>>>>>>> +
>>>>>>> +       mhu_client: scb@2e000000 {
>>>>>>> +       compatible = "fujitsu,mb86s70-scb-1.0";
>>>>>>> +       reg = <0 0x2e000000 0x4000>;
>>>>>>> +       mboxes =
>>>>>>> +               // For multi-word frames, client may only instantiate a single
>>>>>>> +               // mailbox for a mailbox controller
>>>>>>> +               <&mbox_mw_tx 0>,
>>>>>>> +
>>>>>>> +               // For single-word frames, client may instantiate as many
>>>>>>> +               // mailboxes as there are channel windows in the MHU
>>>>>>> +                <&mbox_sw_tx 0>,
>>>>>>> +                <&mbox_sw_tx 1>,
>>>>>>> +                <&mbox_sw_tx 2>,
>>>>>>> +                <&mbox_sw_tx 3>,
>>>>>>> +
>>>>>>> +               // For doorbell frames, client may instantiate as many mailboxes
>>>>>>> +               // as there are bits available in the combined number of channel
>>>>>>> +               // windows ((channel windows * 32) mailboxes)
>>>>>>> +                <mbox_db_rx 0>,
>>>>>>> +                <mbox_db_rx 1>,
>>>>>>> +                ...
>>>>>>> +                <mbox_db_rx 17>;
>>>>>>> +       };
>>>>>>
>>>>>> If the mhuv2 instance implements, say, 3 channel windows between
>>>>>> sender (linux) and receiver (firmware), and Linux runs two protocols
>>>>>> each requiring 1 and 2-word sized messages respectively. The hardware
>>>>>> supports that by assigning windows [0] and [1,2] to each protocol.
>>>>>> However, I don't think the driver can support that. Or does it?
>>>>>>
>>>>> Thinking about it, IMO, the mbox-cell should carry a 128 (4x32) bit
>>>>> mask specifying the set of windows (corresponding to the bits set in
>>>>> the mask) associated with the channel.
>>>>> And the controller driver should see any channel as associated with
>>>>> variable number of windows 'N', where N is [0,124]
>>>>>
>>>>> mhu_client1: proto1@2e000000 {
>>>>>         .....
>>>>>         mboxes = <&mbox 0x0 0x0 0x0 0x1>
>>>>> }
>>>>>
>>>>> mhu_client2: proto2@2f000000 {
>>>>>         .....
>>>>>         mboxes = <&mbox 0x0 0x0 0x0 0x6>
>>>>> }
>>>>>
>>>>> Cheers!
>>>>>
>>>>
>>>> As mentioned in the response to your initial comment, the driver does
>>>> not currently support mixing protocols.
>>>>
>>> Thanks for acknowledging that limitation. But lets also address it.
>>>
>>
>> We are hesitant to dedicate time to developing mixing protocols given
>> that we don't have any current usecase nor any current platform which
>> would support this.
>>
> Can you please share the client code against which you tested this driver?
>  From my past experience, I realise it is much more efficient to tidyup
> the code myself, than endlessly trying to explain the benefits.
> 

Yes, I will share that soon.

> Thanks
> 
