Return-Path: <SRS0=zoc3=WI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B56FC433FF
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB3ED2064A
	for <linux-kernel@archiver.kernel.org>; Mon, 12 Aug 2019 16:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726856AbfHLQ0k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 12 Aug 2019 12:26:40 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:56180 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbfHLQ0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Aug 2019 12:26:39 -0400
Received: by mail-wm1-f68.google.com with SMTP id f72so102243wmf.5
        for <linux-kernel@vger.kernel.org>; Mon, 12 Aug 2019 09:26:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BCSV8W8crhzepNxJm5ULkSzkz8tlFR9gxIdG65AHcyk=;
        b=HFxnm7SZMmtrAeGrxEkcDlsV+LF17xouy+ijpE5vLrZneJoRXzCYuAVF1A7RgayyJE
         VrwZJOXThQLYBK9T5wkeIN+slMb+657BhUtdrjDdl9QXFfeAL2Q8iVwYSASVpzihkPJe
         Eso/feu6TnHvKUo+uWpOtvUsY08jtB6QmBb2CXQhKc8XNjw8lL5MDtq7K1WsBCEmMbzg
         QmSAKBOMdaFMLx8VvEt+ebgbsk/hoVfd2Gb6qigPcmapYisHeWU/gC1CNdVxJCRGNAPu
         hAVDC310s0HfUZJQXPmX0Mz2nEaivq/WavpUoCUM7zt5L4YKxRpBdwWddO51Ju/U5VJL
         6/4w==
X-Gm-Message-State: APjAAAWvyoaUWqggzybROTRy5bjRi8X+PPmyVAcDoVp/Hw4CSaxjXDd4
        a+qvKPVfk8ByswV3+xhGQhGY7D0SfWA=
X-Google-Smtp-Source: APXvYqyG/4/23Y7sZK2DpewmP+kdZ2n2Y2MnTD7Ivy/oXpB7X5leUEUuNTZmoKAgfV7nollf6ogoIw==
X-Received: by 2002:a05:600c:254e:: with SMTP id e14mr143925wma.150.1565627197871;
        Mon, 12 Aug 2019 09:26:37 -0700 (PDT)
Received: from shalem.localdomain (84-106-84-65.cable.dynamic.v4.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id w15sm76719wmi.19.2019.08.12.09.26.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Aug 2019 09:26:37 -0700 (PDT)
Subject: Re: [PATCH] HID: logitech-dj: add support of the G700(s) receiver
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Jiri Kosina <jikos@kernel.org>
Cc:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190812160804.11803-1-benjamin.tissoires@redhat.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <f97403fd-4bf0-f82b-06e7-8bf4dcb2b2aa@redhat.com>
Date:   Mon, 12 Aug 2019 18:26:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190812160804.11803-1-benjamin.tissoires@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 12-08-19 18:08, Benjamin Tissoires wrote:
> Both the G700 and the G700s are sharing the same receiver.
> Include support for this receiver in hid-logitech-dj so that userspace
> can differentiate both.
> 
> Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Nice, looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
>   drivers/hid/hid-logitech-dj.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hid/hid-logitech-dj.c b/drivers/hid/hid-logitech-dj.c
> index c547cba05fbb..d6250b0cb9f8 100644
> --- a/drivers/hid/hid-logitech-dj.c
> +++ b/drivers/hid/hid-logitech-dj.c
> @@ -959,6 +959,7 @@ static void logi_hidpp_recv_queue_notif(struct hid_device *hdev,
>   		break;
>   	case 0x07:
>   		device_type = "eQUAD step 4 Gaming";
> +		logi_hidpp_dev_conn_notif_equad(hdev, hidpp_report, &workitem);
>   		break;
>   	case 0x08:
>   		device_type = "eQUAD step 4 for gamepads";
> @@ -1832,6 +1833,10 @@ static const struct hid_device_id logi_dj_receivers[] = {
>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>   			 USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_2),
>   	 .driver_data = recvr_type_hidpp},
> +	{ /* Logitech G700(s) receiver (0xc531) */
> +	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
> +		0xc531),
> +	 .driver_data = recvr_type_gaming_hidpp},
>   	{ /* Logitech lightspeed receiver (0xc539) */
>   	  HID_USB_DEVICE(USB_VENDOR_ID_LOGITECH,
>   		USB_DEVICE_ID_LOGITECH_NANO_RECEIVER_LIGHTSPEED),
> 
