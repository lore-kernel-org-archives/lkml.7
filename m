Return-Path: <SRS0=2kAr=R3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,FROM_EXCESS_BASE64,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DA3C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:21:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A50921741
	for <linux-kernel@archiver.kernel.org>; Sun, 24 Mar 2019 06:21:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="hdzYNtH+";
	dkim=pass (1024-bit key) header.d=mail.ru header.i=@mail.ru header.b="hdzYNtH+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727727AbfCXGVO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 Mar 2019 02:21:14 -0400
Received: from fallback12.mail.ru ([94.100.179.29]:47014 "EHLO
        fallback12.mail.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbfCXGVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Mar 2019 02:21:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=zQVBcHXSSj9AnkE1e9fK/m8xhVIm8Bkfzr49TpNYx94=;
        b=hdzYNtH+EJGvbr0zvzM2WBVW683eEgJshHhqCNs5jZDqNxVN6aTjI5GAetBCMW9exJbATwyfuIJ9KJtVG7+c6LhZVBW09/1cwIv2I7YxxHsBdvTvIOAL9OdZtC2Etie6VRck5DaHStd9Ei5MDOuhlc4hW+BZWQtkjmYADl+tupw=;
Received: from [10.161.63.3] (port=56274 helo=f380.i.mail.ru)
        by fallback12.m.smailru.net with esmtp (envelope-from <shc_work@mail.ru>)
        id 1h7wVK-0005RR-T8; Sun, 24 Mar 2019 09:21:11 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail2;
        h=References:In-Reply-To:Content-Transfer-Encoding:Content-Type:Message-ID:Reply-To:Date:MIME-Version:Subject:Cc:To:From; bh=zQVBcHXSSj9AnkE1e9fK/m8xhVIm8Bkfzr49TpNYx94=;
        b=hdzYNtH+EJGvbr0zvzM2WBVW683eEgJshHhqCNs5jZDqNxVN6aTjI5GAetBCMW9exJbATwyfuIJ9KJtVG7+c6LhZVBW09/1cwIv2I7YxxHsBdvTvIOAL9OdZtC2Etie6VRck5DaHStd9Ei5MDOuhlc4hW+BZWQtkjmYADl+tupw=;
Received: by f380.i.mail.ru with local (envelope-from <shc_work@mail.ru>)
        id 1h7wV2-0007iU-Bs; Sun, 24 Mar 2019 09:20:52 +0300
Received: by e.mail.ru with HTTP;
        Sun, 24 Mar 2019 09:20:52 +0300
From:   =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
To:     tglx@linutronix.de, yuehaibing@huawei.com, hpa@zytor.com,
        mingo@kernel.org, shc_work@mail.ru, daniel.lezcano@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-tip-commits@vger.kernel.org
Subject: =?UTF-8?B?UmU6IFt0aXA6dGltZXJzL3VyZ2VudF0gY2xvY2tzb3VyY2UvZHJpdmVycy9j?=
 =?UTF-8?B?bHBzNzExeDogTWFrZSBjbHBzNzExeF9jbGtzcmNfaW5pdCgpIHN0YXRpYw==?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
Date:   Sun, 24 Mar 2019 09:20:52 +0300
Reply-To: =?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?= <shc_work@mail.ru>
X-Priority: 3 (Normal)
Message-ID: <1553408452.699853963@f380.i.mail.ru>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-77F55803: 3D9C1A1FBC8562E97F9F52485CB584D7ADE63D71A4B1B0B8691B11D22FA1AB3230CDF0EB01FE3C024AF03A03EF419C77F8D9167951635F18
X-7FA49CB5: 70AAF3C13DB70168C09775C1D3CA48CF6804EF05EF4ADF2AB07C2033C5A38408395957E7521B51C2FE2CE64A2AE681D4725E5C173C3A84C337F46C620FF2CAEECEDC9CE4EAAF84414E70A05D1297E1BBC6CDE5D1141D2B1C9FB4829BD653A3C2E43CE4B7A93554AF3993E04D58DAE8269FA2833FD35BB23D9E625A9149C048EE9ECD01F8117BC8BEA471835C12D1D9774AD6D5ED66289B524E70A05D1297E1BBF6B57BC7E64490611E7FA7ABCAF51C92A417C69337E82CC2CC7F00164DA146DA6F5DAA56C3B73B23E7DDDDC251EA7DABAAAE862A0553A39223F8577A6DFFEA7C1593D163B8AF4A70E2553EE415A7400EEFF80C71ABB335746BA297DBC24807EA27F269C8F02392CD20465B3A5AADEC6827F269C8F02392CD5571747095F342E88FB05168BE4CE3AF
X-Mailru-Sender: 139A7956A63CACCF2A18077BC60D2445CE79DC08C1D37936EC5C759CEE800C4F26BF58DC376B8FBEED073C8B0B556F46346D653DC8F96EBFDC7E5DB24DA7E57B1937939186396399F4ED1D881B4DF0A5EE23CE02E1CB6F8C5FEEDEB644C299C0ED14614B50AE0675
X-Mras: OK
X-Spam: undefined
In-Reply-To: <tip-d18a7408d7be0f34a120d99051ed5187d9727728@git.kernel.org>
References: <20190322143708.12716-1-yuehaibing@huawei.com>
 <tip-d18a7408d7be0f34a120d99051ed5187d9727728@git.kernel.org>
X-77F55803: E8DB3678F13EF3E07F9F52485CB584D7271FD7DF62800FDC346C3E6FD0B958DBC8B99C379CFE161F760E554CF98BC6E470E04671A415C8E0
X-7FA49CB5: 0D63561A33F958A567717898BCA0196AD01D39E0B440DD58C123A3F25BED42CA8941B15DA834481FA18204E546F3947CEDCF5861DED71B2F389733CBF5DBD5E9C8A9BA7A39EFB7666BA297DBC24807EA117882F44604297287769387670735209ECD01F8117BC8BEA471835C12D1D977C4224003CC836476C0CAF46E325F83A50BF2EBBBDD9D6B0F05F538519369F3743B503F486389A921A5CC5B56E945C8DA
X-Mras: OK
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpcyBzaG91bGQgYmUgZml4ZWQgYnkgYXBwbHlpbmcgIltQQVRDSF0gY2xvY2tzb3VyY2U6IGNs
cHM3MTF4OiBSZW1vdmUgYm9hcmQgc3VwcG9ydCIuCmh0dHBzOi8vd3d3LmxrbWwub3JnL2xrbWwv
MjAxOC8xMi8yMC80NjgKCj7QodGD0LHQsdC+0YLQsCwgMjMg0LzQsNGA0YLQsCAyMDE5LCAxOjQ5
ICswMzowMCDQvtGCIHRpcC1ib3QgZm9yIFl1ZUhhaWJpbmcgPHRpcGJvdEB6eXRvci5jb20+Ogo+
Cj5Db21taXQtSUQ6ICBkMThhNzQwOGQ3YmUwZjM0YTEyMGQ5OTA1MWVkNTE4N2Q5NzI3NzI4Cj5H
aXR3ZWI6ICBodHRwczovL2dpdC5rZXJuZWwub3JnL3RpcC9kMThhNzQwOGQ3YmUwZjM0YTEyMGQ5
OTA1MWVkNTE4N2Q5NzI3NzI4Cj5BdXRob3I6ICAgICBZdWVIYWliaW5nIDwgeXVlaGFpYmluZ0Bo
dWF3ZWkuY29tID4KPkF1dGhvckRhdGU6IEZyaSwgMjIgTWFyIDIwMTkgMjI6Mzc6MDggKzA4MDAK
PkNvbW1pdHRlcjogIFRob21hcyBHbGVpeG5lciA8IHRnbHhAbGludXRyb25peC5kZSA+Cj5Db21t
aXREYXRlOiBGcmksIDIyIE1hciAyMDE5IDIyOjU5OjMyICswMTAwCj4KPmNsb2Nrc291cmNlL2Ry
aXZlcnMvY2xwczcxMXg6IE1ha2UgY2xwczcxMXhfY2xrc3JjX2luaXQoKSBzdGF0aWMKPgo+Rml4
IHNwYXJzZSB3YXJuaW5nOgo+Cj5kcml2ZXJzL2Nsb2Nrc291cmNlL2NscHM3MTF4LXRpbWVyLmM6
OTY6MTM6IHdhcm5pbmc6Cj7CoHN5bWJvbCAnY2xwczcxMXhfY2xrc3JjX2luaXQnIHdhcyBub3Qg
ZGVjbGFyZWQuIFNob3VsZCBpdCBiZSBzdGF0aWM/Cj4KPlNpZ25lZC1vZmYtYnk6IFl1ZUhhaWJp
bmcgPCB5dWVoYWliaW5nQGh1YXdlaS5jb20gPgo+U2lnbmVkLW9mZi1ieTogVGhvbWFzIEdsZWl4
bmVyIDwgdGdseEBsaW51dHJvbml4LmRlID4KPkNjOiA8IGRhbmllbC5sZXpjYW5vQGxpbmFyby5v
cmcgPgo+Q2M6IDwgc2hjX3dvcmtAbWFpbC5ydSA+Cj5DYzogPCBsaW51eC1hcm0ta2VybmVsQGxp
c3RzLmluZnJhZGVhZC5vcmcgPgo+TGluazogIGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAx
OTAzMjIxNDM3MDguMTI3MTYtMS15dWVoYWliaW5nQGh1YXdlaS5jb20KPgo+LS0tCj7CoGRyaXZl
cnMvY2xvY2tzb3VyY2UvY2xwczcxMXgtdGltZXIuYyB8IDUgKysrLS0KPsKgMSBmaWxlIGNoYW5n
ZWQsIDMgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPgo+ZGlmZiAtLWdpdCBhL2RyaXZl
cnMvY2xvY2tzb3VyY2UvY2xwczcxMXgtdGltZXIuYyBiL2RyaXZlcnMvY2xvY2tzb3VyY2UvY2xw
czcxMXgtdGltZXIuYwo+aW5kZXggYThkZDgwNTc2Yzk1Li5jZGMyNTE1MjRmNWUgMTAwNjQ0Cj4t
LS0gYS9kcml2ZXJzL2Nsb2Nrc291cmNlL2NscHM3MTF4LXRpbWVyLmMKPisrKyBiL2RyaXZlcnMv
Y2xvY2tzb3VyY2UvY2xwczcxMXgtdGltZXIuYwo+QEAgLTkzLDggKzkzLDkgQEAgc3RhdGljIGlu
dCBfX2luaXQgX2NscHM3MTF4X2Nsa2V2dF9pbml0KHN0cnVjdCBjbGsgKmNsb2NrLCB2b2lkIF9f
aW9tZW0gKmJhc2UsCj7CoCAgICJjbHBzNzExeC10aW1lciIsIGNsa2V2dCk7Cj7CoH0KPsKgCj4t
dm9pZCBfX2luaXQgY2xwczcxMXhfY2xrc3JjX2luaXQodm9pZCBfX2lvbWVtICp0YzFfYmFzZSwg
dm9pZCBfX2lvbWVtICp0YzJfYmFzZSwKPi0gdW5zaWduZWQgaW50IGlycSkKPitzdGF0aWMgdm9p
ZCBfX2luaXQgY2xwczcxMXhfY2xrc3JjX2luaXQodm9pZCBfX2lvbWVtICp0YzFfYmFzZSwKPit2
b2lkIF9faW9tZW0gKnRjMl9iYXNlLAo+K3Vuc2lnbmVkIGludCBpcnEpCj7CoHsKPsKgc3RydWN0
IGNsayAqdGMxID0gY2xrX2dldF9zeXMoImNscHM3MTF4LXRpbWVyLjAiLCBOVUxMKTsKPsKgc3Ry
dWN0IGNsayAqdGMyID0gY2xrX2dldF9zeXMoImNscHM3MTF4LXRpbWVyLjEiLCBOVUxMKTsKCgot
LS0K
