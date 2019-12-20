Return-Path: <SRS0=w7sF=2K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 179D9C43603
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:25:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D50F1206A5
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Dec 2019 14:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727413AbfLTOZV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Dec 2019 09:25:21 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:54427 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727347AbfLTOZU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Dec 2019 09:25:20 -0500
Received: from rabammel.molgen.mpg.de (rabammel.molgen.mpg.de [141.14.30.220])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 7E8B82000BFE3;
        Fri, 20 Dec 2019 15:25:15 +0100 (CET)
Subject: Re: USB devices on Dell TB16 dock stop working after resuming
To:     Mathias Nyman <mathias.nyman@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Mario Limonciello <mario.limonciello@dell.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Christian Kellner <ck@xatom.net>, linux-kernel@vger.kernel.org,
        Anthony Wong <anthony.wong@canonical.com>
References: <20191104154446.GH2552@lahna.fi.intel.com>
 <ea829adedf0445c0845e25d6e4b47905@AUSX13MPC105.AMER.DELL.COM>
 <d8cb6bc6-8145-eaed-5ba4-d7291478bdd7@molgen.mpg.de>
 <20191104162103.GI2552@lahna.fi.intel.com>
 <f0257624-920e-eec4-a2ec-7adf8ecbcc9d@molgen.mpg.de>
 <20191120105048.GY11621@lahna.fi.intel.com>
 <20191122105012.GD11621@lahna.fi.intel.com>
 <edfe1e3c-779b-61e4-8551-f2e13d46d733@molgen.mpg.de>
 <20191122112921.GF11621@lahna.fi.intel.com>
 <ae67c377-4763-4648-a91c-b9351e3b1cf1@molgen.mpg.de>
 <20191122114108.GG11621@lahna.fi.intel.com>
 <cf4140c8-5b92-f1e5-c9e4-e362ab06d6f8@linux.intel.com>
 <e5e3df06-4ddd-aadb-f1ad-6dd24fa2a5c2@molgen.mpg.de>
 <4b25e707-d2b5-11d1-4b16-48122828fde7@linux.intel.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
Message-ID: <a9e12353-6f88-edeb-0d78-15c1ac75666b@molgen.mpg.de>
Date:   Fri, 20 Dec 2019 15:25:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4b25e707-d2b5-11d1-4b16-48122828fde7@linux.intel.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms020307020207010209000909"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms020307020207010209000909
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Dear Mathias,


On 2019-11-26 13:44, Mathias Nyman wrote:
> On 26.11.2019 13.33, Paul Menzel wrote:

>> On 2019-11-25 10:20, Mathias Nyman wrote:
>>> On 22.11.2019 13.41, Mika Westerberg wrote:
>>>> On Fri, Nov 22, 2019 at 12:33:44PM +0100, Paul Menzel wrote:
>>
>>>>> On 2019-11-22 12:29, Mika Westerberg wrote:
>>>>>> On Fri, Nov 22, 2019 at 12:05:13PM +0100, Paul Menzel wrote:
>>>>>
>>>>>>> On 2019-11-22 11:50, Mika Westerberg wrote:
>>>>>>>> On Wed, Nov 20, 2019 at 12:50:53PM +0200, Mika Westerberg wrote:=

>>>>>>>>> On Tue, Nov 19, 2019 at 05:55:43PM +0100, Paul Menzel wrote:
>>>>>>>
>>>>>>>>>> On 2019-11-04 17:21, Mika Westerberg wrote:
>>>>>>>>>>> On Mon, Nov 04, 2019 at 05:11:10PM +0100, Paul Menzel wrote:
>>>>>>>>>>
>>>>>>>>>>>> On 2019-11-04 16:49, Mario.Limonciello@dell.com wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>>> From: Mika Westerberg <mika.westerberg@linux.intel.com>
>>>>>>>>>>>>>> Sent: Monday, November 4, 2019 9:45 AM
>>>>>>>>>>>>
>>>>>>>>>>>>>> On Mon, Nov 04, 2019 at 04:44:40PM +0200, Mika Westerberg =
wrote:
>>>>>>>>>>>>>>> On Mon, Nov 04, 2019 at 04:25:03PM +0200, Mika Westerberg=
 wrote:
>>>>>>>>>>>>
>>>>>>>>>>>>>>>> On Mon, Nov 04, 2019 at 02:13:13PM +0100, Paul Menzel wr=
ote:
>>>>>>>>>>>>
>>>>>>>>>>>>>>>>> On the Dell XPS 13 9380 with Debian Sid/unstable with L=
inux 5.3.7
>>>>>>>>>>>>>>>>> suspending the system, and resuming with Dell=E2=80=99s=
 Thunderbolt TB16
>>>>>>>>>>>>>>>>> dock connected, the USB input devices, keyboard and mou=
se,
>>>>>>>>>>>>>>>>> connected to the TB16 stop working. They work for a few=
 seconds
>>>>>>>>>>>>>>>>> (mouse cursor can be moved), but then stop working. The=
 laptop
>>>>>>>>>>>>>>>>> keyboard and touchpad still works fine. All firmware is=
 up-to-date
>>>>>>>>>>>>>>>>> according to `fwupdmgr`.
>>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>>> What are the exact steps to reproduce? Just "echo mem >
>>>>>>>>>>>>>>>> /sys/power/state" and then resume by pressing power butt=
on?
>>>>>>>>>>>>
>>>>>>>>>>>> GNOME Shell 3.34.1+git20191024-1 is used, and the user just =
closes the
>>>>>>>>>>>> display. So more than `echo mem > /sys/power/state` is done.=
 What
>>>>>>>>>>>> distribution do you use?
>>>>>>>>>>>
>>>>>>>>>>> I have buildroot based "distro" so there is no UI running.
>>>>>>>>>>
>>>>>>>>>> Hmm, this is quite different from the =E2=80=9Cnormal=E2=80=9D=
 use-case of the these devices.
>>>>>>>>>> That way you won=E2=80=99t hit the bugs of the normal users. ;=
-)
>>>>>>>>>
>>>>>>>>> Well, I can install some distro to that thing also :) I suppose=
 Debian
>>>>>>>>> 10.2 does have this issue, no?
>>>>>>>>>
>>>>>>>>>>>>>>> I tried v5.4-rc6 on my 9380 with TB16 dock connected and =
did a couple of
>>>>>>>>>>>>>>> suspend/resume cycles (to s2idle) but I don't see any iss=
ues.
>>>>>>>>>>>>>>>
>>>>>>>>>>>>>>> I may have older/different firmware than you, though.
>>>>>>>>>>>>>>
>>>>>>>>>>>>>> Upgraded BIOS to 1.8.0 and TBT NVM to v44 but still can't =
reproduce this
>>>>>>>>>>>>>> on my system :/
>>>>>>>>>>>>
>>>>>>>>>>>> The user reported the issue with the previous firmwares 1.x =
and TBT NVM v40.
>>>>>>>>>>>> Updating to the recent version (I got the logs with) did not=
 fix the issue.
>>>>>>>>>>>
>>>>>>>>>>> I also tried v40 (that was originally on that system) but I w=
as not able
>>>>>>>>>>> to reproduce it.
>>>>>>>>>>>
>>>>>>>>>>> Do you know if the user changed any BIOS settings?
>>>>>>>>>>
>>>>>>>>>> We had to disable the Thunderbolt security settings as otherwi=
se the USB
>>>>>>>>>> devices wouldn=E2=80=99t work at cold boot either.
>>>>>>>>>
>>>>>>>>> That does not sound right at all. There is the preboot ACL that=
 allows
>>>>>>>>> you to use TBT dock aready on boot. Bolt takes care of this.
>>>>>>>>>
>>>>>>>>> Are you talking about USB devices connected to the TB16 dock?
>>>>>>>>>
>>>>>>>>> Also are you connecting the TB16 dock to the Thunderbolt ports =
(left
>>>>>>>>> side of the system marked with small lightning logo) or to the =
normal
>>>>>>>>> Type-C ports (right side)?
>>>>>>>>>
>>>>>>>>>> So, I built Linux 5.4-rc8 (`make bindeb-pkg -j8`), but unfortu=
nately the
>>>>>>>>>> error is still there. Sometimes, re-plugging the dock helped, =
and sometimes
>>>>>>>>>> it did not.
>>>>>>>>>>
>>>>>>>>>> Please find the logs attached. The strange thing is, the Linux=
 kernel detects
>>>>>>>>>> the devices and I do not see any disconnect events. But, `lsus=
b` does not list
>>>>>>>>>> the keyboard and the mouse. Is that expected.
>>>>>>>>>
>>>>>>>>> I'm bit confused. Can you describe the exact steps what you do =
(so I can
>>>>>>>>> replicate them).
>>>>>>>>
>>>>>>>> I managed to reproduce following scenario.
>>>>>>>>
>>>>>>>> 1. Boot the system up to UI
>>>>>>>> 2. Connect TB16 dock (and see that it gets authorized by bolt)
>>>>>>>> 3. Connect keyboard and mouse to the TB16 dock
>>>>>>>> 4. Both mouse and keyboard are functional
>>>>>>>> 5. Enter s2idle by closing laptop lid
>>>>>>>> 6. Exit s2idle by opening the laptop lid
>>>>>>>> 7. After ~10 seconds or so the mouse or keyboard or both do not =
work
>>>>>>>> =C2=A0=C2=A0=C2=A0=C2=A0 anymore. They do not respond but they a=
re still "present".
>>>>>>>>
>>>>>>>> The above does not happen always but from time to time.
>>>>>>>>
>>>>>>>> Is this the scenario you see as well?
>>>>>>>
>>>>>>> Yes, it is. Though I=E2=80=99d say it=E2=80=99s only five seconds=
 or so.
>>>>>>>
>>>>>>>> This is on Ubuntu 19.10 with the 5.3 stock kernel.
>>>>>>>
>>>>>>> =E2=80=9Cstock=E2=80=9D in upstream=E2=80=99s or Ubuntu=E2=80=99s=
?
>>>>>>
>>>>>> It is Ubuntu's.
>>>>>>
>>>>>>>> I can get them work again by unplugging them and plugging back (=
leaving
>>>>>>>> the TBT16 dock connected). Also if you run lspci when the proble=
m
>>>>>>>> occurs it still shows the dock so PCIe link stays up.
>>>>>>>
>>>>>>> Re-connecting the USB devices does not help here, but I still sus=
pect it=E2=80=99s
>>>>>>> the same issue.
>>>>>>
>>>>>> Yeah, sounds like so. Did you try to connect the device (mouse,
>>>>>> keyboard) to another USB port?
>>>>>
>>>>> I do not think I did, but I can=E2=80=99t remember. Next week would=
 be the next chance
>>>>> to test this.
>>>>>
>>>>>>> Yesterday, I had my hand on a Dell XPS 13 7390 (10th Intel genera=
tion) and
>>>>>>> tried it with the shipped Ubuntu 18.04 LTS. There, the problem wa=
s not
>>>>>>> always reproducible, but it still happened. Sometimes, only one o=
f the USB
>>>>>>> device (either keyboard or mouse) stopped working.
>>>>>>
>>>>>> I suppose this is also with the TB16 dock connected, correct?
>>>>>
>>>>> Correct.
>>>>>
>>>>> Can I ask again, how the USB devices connected to the dock can be l=
isted on
>>>>> the command line? lsusb needs to be adapted for that or is a differ=
ent
>>>>> mechanism needed?
>>>>
>>>> The TB16 dock has ASMEDIA xHCI controller, which is PCIe device so y=
ou
>>>> can see it by running lsusb and looking at the devices under that
>>>> controller. I think maybe 'lsusb -t' is helpful.
>>>>
>>>> The xHCI controller itself you can see by running lspci.
>>>
>>> I got traces from the ASMedia xHC controller in the TB16 dock.
>>
>> Nice. Thank you for looking into that. How can these traces be capture=
d?
>=20
> The Linux tracepoints added to the xhci driver can be enabled by:
>=20
> mount -t debugfs none /sys/kernel/debug
> echo 81920 > /sys/kernel/debug/tracing/buffer_size_kb
> echo 1 > /sys/kernel/debug/tracing/events/xhci-hcd/enable
> < Trigger the issue >
>=20
> Copy traces found in /sys/kernel/debug/tracing/trace
>=20
> Trace file grows fast.

>>> There are issues with split transactions between the ASMedia host and=
 the 7 port
>>> High speed hub built in to the dock.
>>>
>>> host reports a split transaction error for mouse or keyboard full-spe=
ed/low-speed
>>> interrupt transactions. Endpoint doesn't recover after resetting it.
>>>
>>> Split transaction allows full- and low-speed devices to be attached t=
o high-speed
>>> hubs, and are used only between the host and the HS hub. A transactio=
n translator (TT)
>>> in the HS hub will translate the high-speed split transactions on its=
 upstream port to
>>> low/full speed transactions on the downstream port.
>>>
>>> I'll see if there are any xHC parameters driver is setting that trigg=
er these
>>> split transaction errors to trigger more easy.
>>
>> I always wonder how Microsoft Windows driver do it.
>>
>> Mario, should I contact the Dell support regarding this issue?
Sorry for bothering, but were you able to find some workaround for this i=
ssue?


Kind regards,

Paul


--------------ms020307020207010209000909
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExDzANBglghkgBZQMEAgEFADCABgkqhkiG9w0BBwEAAKCC
EFowggUSMIID+qADAgECAgkA4wvV+K8l2YEwDQYJKoZIhvcNAQELBQAwgYIxCzAJBgNVBAYT
AkRFMSswKQYDVQQKDCJULVN5c3RlbXMgRW50ZXJwcmlzZSBTZXJ2aWNlcyBHbWJIMR8wHQYD
VQQLDBZULVN5c3RlbXMgVHJ1c3QgQ2VudGVyMSUwIwYDVQQDDBxULVRlbGVTZWMgR2xvYmFs
Um9vdCBDbGFzcyAyMB4XDTE2MDIyMjEzMzgyMloXDTMxMDIyMjIzNTk1OVowgZUxCzAJBgNV
BAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1dHNjaGVu
IEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNVBAMTJERG
Ti1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBAMtg1/9moUHN0vqHl4pzq5lN6mc5WqFggEcVToyVsuXPztNXS43O+FZs
FVV2B+pG/cgDRWM+cNSrVICxI5y+NyipCf8FXRgPxJiZN7Mg9mZ4F4fCnQ7MSjLnFp2uDo0p
eQcAIFTcFV9Kltd4tjTTwXS1nem/wHdN6r1ZB+BaL2w8pQDcNb1lDY9/Mm3yWmpLYgHurDg0
WUU2SQXaeMpqbVvAgWsRzNI8qIv4cRrKO+KA3Ra0Z3qLNupOkSk9s1FcragMvp0049ENF4N1
xDkesJQLEvHVaY4l9Lg9K7/AjsMeO6W/VRCrKq4Xl14zzsjz9AkH4wKGMUZrAcUQDBHHWekC
AwEAAaOCAXQwggFwMA4GA1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUk+PYMiba1fFKpZFK4OpL
4qIMz+EwHwYDVR0jBBgwFoAUv1kgNgB5oKAia4zV8mHSuCzLgkowEgYDVR0TAQH/BAgwBgEB
/wIBAjAzBgNVHSAELDAqMA8GDSsGAQQBga0hgiwBAQQwDQYLKwYBBAGBrSGCLB4wCAYGZ4EM
AQICMEwGA1UdHwRFMEMwQaA/oD2GO2h0dHA6Ly9wa2kwMzM2LnRlbGVzZWMuZGUvcmwvVGVs
ZVNlY19HbG9iYWxSb290X0NsYXNzXzIuY3JsMIGGBggrBgEFBQcBAQR6MHgwLAYIKwYBBQUH
MAGGIGh0dHA6Ly9vY3NwMDMzNi50ZWxlc2VjLmRlL29jc3ByMEgGCCsGAQUFBzAChjxodHRw
Oi8vcGtpMDMzNi50ZWxlc2VjLmRlL2NydC9UZWxlU2VjX0dsb2JhbFJvb3RfQ2xhc3NfMi5j
ZXIwDQYJKoZIhvcNAQELBQADggEBAIcL/z4Cm2XIVi3WO5qYi3FP2ropqiH5Ri71sqQPrhE4
eTizDnS6dl2e6BiClmLbTDPo3flq3zK9LExHYFV/53RrtCyD2HlrtrdNUAtmB7Xts5et6u5/
MOaZ/SLick0+hFvu+c+Z6n/XUjkurJgARH5pO7917tALOxrN5fcPImxHhPalR6D90Bo0fa3S
PXez7vTXTf/D6OWST1k+kEcQSrCFWMBvf/iu7QhCnh7U3xQuTY+8npTD5+32GPg8SecmqKc2
2CzeIs2LgtjZeOJVEqM7h0S2EQvVDFKvaYwPBt/QolOLV5h7z/0HJPT8vcP9SpIClxvyt7bP
ZYoaorVyGTkwggWNMIIEdaADAgECAgwcOtRQhH7u81j4jncwDQYJKoZIhvcNAQELBQAwgZUx
CzAJBgNVBAYTAkRFMUUwQwYDVQQKEzxWZXJlaW4genVyIEZvZXJkZXJ1bmcgZWluZXMgRGV1
dHNjaGVuIEZvcnNjaHVuZ3NuZXR6ZXMgZS4gVi4xEDAOBgNVBAsTB0RGTi1QS0kxLTArBgNV
BAMTJERGTi1WZXJlaW4gQ2VydGlmaWNhdGlvbiBBdXRob3JpdHkgMjAeFw0xNjExMDMxNTI0
NDhaFw0zMTAyMjIyMzU5NTlaMGoxCzAJBgNVBAYTAkRFMQ8wDQYDVQQIDAZCYXllcm4xETAP
BgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxhbmNrLUdlc2VsbHNjaGFmdDEVMBMG
A1UEAwwMTVBHIENBIC0gRzAyMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAnhx4
59Lh4WqgOs/Md04XxU2yFtfM15ZuJV0PZP7BmqSJKLLPyqmOrADfNdJ5PIGBto2JBhtRRBHd
G0GROOvTRHjzOga95WOTeura79T21FWwwAwa29OFnD3ZplQs6HgdwQrZWNi1WHNJxn/4mA19
rNEBUc5urSIpZPvZi5XmlF3v3JHOlx3KWV7mUteB4pwEEfGTg4npPAJbp2o7arxQdoIq+Pu2
OsvqhD7Rk4QeaX+EM1QS4lqd1otW4hE70h/ODPy1xffgbZiuotWQLC6nIwa65Qv6byqlIX0q
Zuu99Vsu+r3sWYsL5SBkgecNI7fMJ5tfHrjoxfrKl/ErTAt8GQIDAQABo4ICBTCCAgEwEgYD
VR0TAQH/BAgwBgEB/wIBATAOBgNVHQ8BAf8EBAMCAQYwKQYDVR0gBCIwIDANBgsrBgEEAYGt
IYIsHjAPBg0rBgEEAYGtIYIsAQEEMB0GA1UdDgQWBBTEiKUH7rh7qgwTv9opdGNSG0lwFjAf
BgNVHSMEGDAWgBST49gyJtrV8UqlkUrg6kviogzP4TCBjwYDVR0fBIGHMIGEMECgPqA8hjpo
dHRwOi8vY2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jcmwvY2Fjcmwu
Y3JsMECgPqA8hjpodHRwOi8vY2RwMi5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1
Yi9jcmwvY2FjcmwuY3JsMIHdBggrBgEFBQcBAQSB0DCBzTAzBggrBgEFBQcwAYYnaHR0cDov
L29jc3AucGNhLmRmbi5kZS9PQ1NQLVNlcnZlci9PQ1NQMEoGCCsGAQUFBzAChj5odHRwOi8v
Y2RwMS5wY2EuZGZuLmRlL2dsb2JhbC1yb290LWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNy
dDBKBggrBgEFBQcwAoY+aHR0cDovL2NkcDIucGNhLmRmbi5kZS9nbG9iYWwtcm9vdC1nMi1j
YS9wdWIvY2FjZXJ0L2NhY2VydC5jcnQwDQYJKoZIhvcNAQELBQADggEBABLpeD5FygzqOjj+
/lAOy20UQOGWlx0RMuPcI4nuyFT8SGmK9lD7QCg/HoaJlfU/r78ex+SEide326evlFAoJXIF
jVyzNltDhpMKrPIDuh2N12zyn1EtagqPL6hu4pVRzcBpl/F2HCvtmMx5K4WN1L1fmHWLcSap
dhXLvAZ9RG/B3rqyULLSNN8xHXYXpmtvG0VGJAndZ+lj+BH7uvd3nHWnXEHC2q7iQlDUqg0a
wIqWJgdLlx1Q8Dg/sodv0m+LN0kOzGvVDRCmowBdWGhhusD+duKV66pBl+qhC+4LipariWaM
qK5ppMQROATjYeNRvwI+nDcEXr2vDaKmdbxgDVwwggWvMIIEl6ADAgECAgweKlJIhfynPMVG
/KIwDQYJKoZIhvcNAQELBQAwajELMAkGA1UEBhMCREUxDzANBgNVBAgMBkJheWVybjERMA8G
A1UEBwwITXVlbmNoZW4xIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MRUwEwYD
VQQDDAxNUEcgQ0EgLSBHMDIwHhcNMTcxMTE0MTEzNDE2WhcNMjAxMTEzMTEzNDE2WjCBizEL
MAkGA1UEBhMCREUxIDAeBgNVBAoMF01heC1QbGFuY2stR2VzZWxsc2NoYWZ0MTQwMgYDVQQL
DCtNYXgtUGxhbmNrLUluc3RpdHV0IGZ1ZXIgbW9sZWt1bGFyZSBHZW5ldGlrMQ4wDAYDVQQL
DAVNUElNRzEUMBIGA1UEAwwLUGF1bCBNZW56ZWwwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAw
ggEKAoIBAQDIh/UR/AX/YQ48VWWDMLTYtXjYJyhRHMc81ZHMMoaoG66lWB9MtKRTnB5lovLZ
enTIUyPsCrMhTqV9CWzDf6v9gOTWVxHEYqrUwK5H1gx4XoK81nfV8oGV4EKuVmmikTXiztGz
peyDmOY8o/EFNWP7YuRkY/lPQJQBeBHYq9AYIgX4StuXu83nusq4MDydygVOeZC15ts0tv3/
6WmibmZd1OZRqxDOkoBbY3Djx6lERohs3IKS6RKiI7e90rCSy9rtidJBOvaQS9wvtOSKPx0a
+2pAgJEVzZFjOAfBcXydXtqXhcpOi2VCyl+7+LnnTz016JJLsCBuWEcB3kP9nJYNAgMBAAGj
ggIxMIICLTAJBgNVHRMEAjAAMA4GA1UdDwEB/wQEAwIF4DAdBgNVHSUEFjAUBggrBgEFBQcD
AgYIKwYBBQUHAwQwHQYDVR0OBBYEFHM0Mc3XjMLlhWpp4JufRELL4A/qMB8GA1UdIwQYMBaA
FMSIpQfuuHuqDBO/2il0Y1IbSXAWMCAGA1UdEQQZMBeBFXBtZW56ZWxAbW9sZ2VuLm1wZy5k
ZTB9BgNVHR8EdjB0MDigNqA0hjJodHRwOi8vY2RwMS5wY2EuZGZuLmRlL21wZy1nMi1jYS9w
dWIvY3JsL2NhY3JsLmNybDA4oDagNIYyaHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzIt
Y2EvcHViL2NybC9jYWNybC5jcmwwgc0GCCsGAQUFBwEBBIHAMIG9MDMGCCsGAQUFBzABhido
dHRwOi8vb2NzcC5wY2EuZGZuLmRlL09DU1AtU2VydmVyL09DU1AwQgYIKwYBBQUHMAKGNmh0
dHA6Ly9jZHAxLnBjYS5kZm4uZGUvbXBnLWcyLWNhL3B1Yi9jYWNlcnQvY2FjZXJ0LmNydDBC
BggrBgEFBQcwAoY2aHR0cDovL2NkcDIucGNhLmRmbi5kZS9tcGctZzItY2EvcHViL2NhY2Vy
dC9jYWNlcnQuY3J0MEAGA1UdIAQ5MDcwDwYNKwYBBAGBrSGCLAEBBDARBg8rBgEEAYGtIYIs
AQEEAwYwEQYPKwYBBAGBrSGCLAIBBAMGMA0GCSqGSIb3DQEBCwUAA4IBAQCQs6bUDROpFO2F
Qz2FMgrdb39VEo8P3DhmpqkaIMC5ZurGbbAL/tAR6lpe4af682nEOJ7VW86ilsIJgm1j0ueY
aOuL8jrN4X7IF/8KdZnnNnImW3QVni6TCcc+7+ggci9JHtt0IDCj5vPJBpP/dKXLCN4M+exl
GXYpfHgxh8gclJPY1rquhQrihCzHfKB01w9h9tWZDVMtSoy9EUJFhCXw7mYUsvBeJwZesN2B
fndPkrXx6XWDdU3S1LyKgHlLIFtarLFm2Hb5zAUR33h+26cN6ohcGqGEEzgIG8tXS8gztEaj
1s2RyzmKd4SXTkKR3GhkZNVWy+gM68J7jP6zzN+cMYIDmjCCA5YCAQEwejBqMQswCQYDVQQG
EwJERTEPMA0GA1UECAwGQmF5ZXJuMREwDwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4
LVBsYW5jay1HZXNlbGxzY2hhZnQxFTATBgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzF
RvyiMA0GCWCGSAFlAwQCAQUAoIIB8TAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqG
SIb3DQEJBTEPFw0xOTEyMjAxNDI1MTVaMC8GCSqGSIb3DQEJBDEiBCDDbiradOZi2lEbEIUs
7QZJj+5Hmj0ww7CK9h9lxqJo/TBsBgkqhkiG9w0BCQ8xXzBdMAsGCWCGSAFlAwQBKjALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGJBgkrBgEEAYI3EAQxfDB6MGoxCzAJBgNVBAYTAkRF
MQ8wDQYDVQQIDAZCYXllcm4xETAPBgNVBAcMCE11ZW5jaGVuMSAwHgYDVQQKDBdNYXgtUGxh
bmNrLUdlc2VsbHNjaGFmdDEVMBMGA1UEAwwMTVBHIENBIC0gRzAyAgweKlJIhfynPMVG/KIw
gYsGCyqGSIb3DQEJEAILMXygejBqMQswCQYDVQQGEwJERTEPMA0GA1UECAwGQmF5ZXJuMREw
DwYDVQQHDAhNdWVuY2hlbjEgMB4GA1UECgwXTWF4LVBsYW5jay1HZXNlbGxzY2hhZnQxFTAT
BgNVBAMMDE1QRyBDQSAtIEcwMgIMHipSSIX8pzzFRvyiMA0GCSqGSIb3DQEBAQUABIIBAJSV
UFM/0N2dB5ot0KH9Ei6uaV8GkH5V9VNPmrHaSy5tx/0iNzFrTUu/NkeD9sJ3B6z27aCQM/48
twnFu4xHMGJWy92jyZ9Jgu8vmLxsYIFiOWWsH1QzgUs8cPcyfUA+QGqrRyHTNkizYibnVJsc
1qNg7LcBS/AiapdAphgds5okqy4rpN6sAwtVh1zeV0tbJP0bEJh7Of3wMAdKSoxgueboehD/
HK3JZgsxRRwCMck4sthsxFT7JeNqRxeiSovG6upyYm+qNt5Ddq+fCX7O/3rn4Do3VugSxilQ
XM5RoX3NASEftx0/rgaZrsciTy/uwlbgWoMEwFZBCgzEU9X4QAwAAAAAAAA=
--------------ms020307020207010209000909--
